//
//  GravityView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import SwiftUI
import SpriteKit
import CoreMotion

private enum ChipLayout {
    static let hPad:   CGFloat = 16
    static let gap:    CGFloat = 10
    static let chipH:  CGFloat = 50
    static let rowGap: CGFloat = 10
}

func chipWidth(for genre: Genre) -> CGFloat {
    let font  = UIFont.systemFont(ofSize: 16, weight: .medium)
    let textW = (genre.name as NSString).size(withAttributes: [.font: font]).width
    return textW + 28 + 36
}

func buildRows(genres: [Genre], canvasWidth: CGFloat) -> [[Genre]] {
    let usableW = canvasWidth - ChipLayout.hPad * 2
    var rows: [[Genre]] = [[]]
    for genre in genres {
        let w        = chipWidth(for: genre)
        let rowWidth = rows.last!.reduce(CGFloat(0)) { $0 + chipWidth(for: $1) + ChipLayout.gap }
        if rowWidth + w > usableW, !rows.last!.isEmpty {
            rows.append([genre])
        } else {
            rows[rows.count - 1].append(genre)
        }
    }
    return rows
}

final class ChipNode: SKNode {

    let genreName: String
    private(set) var isSelected = false
    private let bg:    SKShapeNode
    private let label: SKLabelNode
    let chipW: CGFloat

    init(genre: Genre) {
        genreName = genre.name
        chipW     = chipWidth(for: genre)

        let rect = CGRect(
            x: -chipW / 2,
            y: -ChipLayout.chipH / 2,
            width:  chipW,
            height: ChipLayout.chipH
        )
        let path = UIBezierPath(roundedRect: rect, cornerRadius: ChipLayout.chipH / 2).cgPath

        bg = SKShapeNode(path: path)
        bg.fillColor   = UIColor(white: 0.16, alpha: 1)
        bg.strokeColor = UIColor(white: 0.4,  alpha: 1)
        bg.lineWidth   = 1.5

        label = SKLabelNode(text: "\(genre.emoji)  \(genre.name)")
        label.fontName              = "SFProText-Medium"
        label.fontSize              = 16
        label.fontColor             = .white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center

        super.init()
        addChild(bg)
        addChild(label)

        physicsBody = SKPhysicsBody(polygonFrom: path)
        physicsBody?.restitution    = 0.10
        physicsBody?.friction       = 1.0
        physicsBody?.linearDamping  = 0.6
        physicsBody?.allowsRotation = true
        physicsBody?.angularDamping = 3.0
        physicsBody?.mass           = 0.4
    }

    required init?(coder: NSCoder) { fatalError() }

    func toggleSelected() {
        isSelected.toggle()
        run(SKAction.sequence([
            SKAction.scale(to: 1.1, duration: 0.08),
            SKAction.scale(to: 1.0, duration: 0.08)
        ]))
        bg.fillColor    = isSelected ? .white              : UIColor(white: 0.16, alpha: 1)
        bg.strokeColor  = isSelected ? .white              : UIColor(white: 0.4,  alpha: 1)
        label.fontColor = isSelected ? .black              : .white
    }
}

final class GravityScene: SKScene {

    var genres: [Genre] = []
    var onSelectionChanged: (([Genre]) -> Void)?
    private var selectionMap: [String: Bool] = [:]

    // Chips stay this far clear of the canvas edges — below the title, above
    // the button — on every side, so a floor when upright becomes a ceiling
    // when the device is flipped upside down, and the pile never overlaps
    // either neighbor.
    private let edgePadding: CGFloat = 16

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.gravity = CGVector(dx: 0, dy: -14)

        let floorY = edgePadding
        let ceilingY = size.height - edgePadding

        addEdge(from: CGPoint(x: 0, y: floorY),
                to:   CGPoint(x: size.width, y: floorY),
                friction: 1.0, restitution: 0.05)

        addEdge(from: CGPoint(x: 0, y: ceilingY),
                to:   CGPoint(x: size.width, y: ceilingY),
                friction: 1.0, restitution: 0.05)

        addEdge(from: CGPoint(x: ChipLayout.hPad / 2, y: floorY),
                to:   CGPoint(x: ChipLayout.hPad / 2, y: ceilingY))

        addEdge(from: CGPoint(x: size.width - ChipLayout.hPad / 2, y: floorY),
                to:   CGPoint(x: size.width - ChipLayout.hPad / 2, y: ceilingY))

        dropChips()
    }

    private func addEdge(from a: CGPoint, to b: CGPoint,
                         friction: CGFloat = 0.8, restitution: CGFloat = 0.1) {
        let n = SKNode()
        n.physicsBody = SKPhysicsBody(edgeFrom: a, to: b)
        n.physicsBody?.friction    = friction
        n.physicsBody?.restitution = restitution
        addChild(n)
    }

    private func dropChips() {
        let rows    = buildRows(genres: genres, canvasWidth: size.width)
        let usableW = size.width - ChipLayout.hPad * 2
        let ceilingY = size.height - edgePadding
        var index   = 0

        for row in rows {
            let rowW   = row.reduce(CGFloat(0)) { $0 + chipWidth(for: $1) + ChipLayout.gap } - ChipLayout.gap
            var cursor = ChipLayout.hPad + (usableW - rowW) / 2

            for genre in row {
                let w       = chipWidth(for: genre)
                let targetX = cursor + w / 2
                cursor     += w + ChipLayout.gap

                let delay  = Double(index) * 0.09
                let spawnX = targetX + CGFloat.random(in: -12...12)
                // Just under the ceiling edge, not above it — the ceiling is a
                // solid collider now, so spawning past it would strand chips
                // there instead of letting them fall to the floor.
                let spawnY = ceilingY - CGFloat.random(in: 0...60)
                // Give each chip a small random angular impulse so they
                // arrive at different resting angles — not all the same tilt.
                let angularImpulse = CGFloat.random(in: -0.3...0.3)
                index += 1

                run(SKAction.wait(forDuration: delay)) { [weak self] in
                    guard let self else { return }
                    let chip = ChipNode(genre: genre)
                    chip.position = CGPoint(x: spawnX, y: spawnY)
                    chip.physicsBody?.velocity = CGVector(
                        dx: CGFloat.random(in: -25...25),
                        dy: CGFloat.random(in: -10...0)
                    )
                    chip.physicsBody?.applyAngularImpulse(angularImpulse)
                    self.addChild(chip)
                }
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let pt = touches.first?.location(in: self) else { return }
        for node in nodes(at: pt) {
            let chip = (node as? ChipNode) ?? (node.parent as? ChipNode)
            if let chip {
                chip.toggleSelected()
                selectionMap[chip.genreName] = chip.isSelected
                onSelectionChanged?(genres.map {
                    var c = $0; c.isSelected = selectionMap[$0.name] ?? false; return c
                })
                break
            }
        }
    }
}

final class GravityView: SKView {
    var genres: [Genre] = []
    var onSelectionChanged: (([Genre]) -> Void)?
    private var sceneCreated = false
    private weak var gravityScene: GravityScene?
    private let motionManager = CMMotionManager()

    override func layoutSubviews() {
        super.layoutSubviews()
        guard !sceneCreated, bounds.width > 0, bounds.height > 0 else { return }
        sceneCreated        = true
        backgroundColor     = .clear
        allowsTransparency  = true
        ignoresSiblingOrder = true

        let scene = GravityScene(size: bounds.size)
        scene.scaleMode          = .resizeFill
        scene.genres             = genres
        scene.onSelectionChanged = onSelectionChanged
        presentScene(scene)
        gravityScene = scene

        startFollowingDeviceTilt()
    }

    // Points gravity toward whichever edge is physically "down" — upright falls
    // down, rotated right falls right — so the pile stays believable through
    // any device rotation without depending on the interface orientation.
    private func startFollowingDeviceTilt() {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, _ in
            guard let self, let acceleration = data?.acceleration else { return }
            let magnitude: CGFloat = 14
            self.gravityScene?.physicsWorld.gravity = CGVector(
                dx: CGFloat(acceleration.x) * magnitude,
                dy: CGFloat(acceleration.y) * magnitude
            )
        }
    }
}

struct GravityBoard: UIViewRepresentable {
    let genres: [Genre]
    var onSelectionChanged: ([Genre]) -> Void

    func makeUIView(context: Context) -> GravityView {
        let v = GravityView()
        v.genres             = genres
        v.onSelectionChanged = onSelectionChanged
        return v
    }
    func updateUIView(_ uiView: GravityView, context: Context) {
        uiView.onSelectionChanged = onSelectionChanged
    }
}
