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
    // Fires once, after this scene has actually drawn its first frame —
    // see `GravityView.init` for why the view stays hidden until then.
    var onFirstFrameRendered: (() -> Void)?
    private var hasRenderedFirstFrame = false
    private var selectionMap: [String: Bool] = [:]

    // Chips stay this far clear of the canvas edges — below the title, above
    // the button — on every side, so a floor when upright becomes a ceiling
    // when the device is flipped upside down, and the pile never overlaps
    // either neighbor.
    private let edgePadding: CGFloat = 16
    private var ceilingAdded = false

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)

        let floorY = edgePadding

        addEdge(from: CGPoint(x: 0, y: floorY),
                to:   CGPoint(x: size.width, y: floorY),
                friction: 1.0, restitution: 0.05)

        // The ceiling collider is added later, once chips have finished
        // falling (see `enableCeilingCollider`) — adding it now would catch
        // chips spawned above it (off the top of the screen) before they
        // ever fall into view.
        addEdge(from: CGPoint(x: ChipLayout.hPad / 2, y: floorY),
                to:   CGPoint(x: ChipLayout.hPad / 2, y: size.height))

        addEdge(from: CGPoint(x: size.width - ChipLayout.hPad / 2, y: floorY),
                to:   CGPoint(x: size.width - ChipLayout.hPad / 2, y: size.height))

        dropChips()
    }

    // Called once chips have had time to land — see `GravityView`'s settle
    // delay. Lets the device-tilt gravity flip use the floor as a ceiling
    // when the phone is upside down, without stranding freshly spawned
    // chips above it during the initial drop.
    func enableCeilingCollider() {
        guard !ceilingAdded else { return }
        ceilingAdded = true
        let ceilingY = size.height - edgePadding
        addEdge(from: CGPoint(x: 0, y: ceilingY),
                to:   CGPoint(x: size.width, y: ceilingY),
                friction: 1.0, restitution: 0.05)
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
        let minX = ChipLayout.hPad
        let maxX = size.width - ChipLayout.hPad

        for genre in genres {
            let w = chipWidth(for: genre)
            let halfW = w / 2
            // Independent random X per chip — not a precomputed, centered
            // row layout — so chips rain down evenly across the full width
            // instead of clustering toward the middle.
            let spawnX = CGFloat.random(in: min(minX + halfW, maxX - halfW)...max(minX + halfW, maxX - halfW))
            // Above the top of the screen, not just near it — chips fall
            // in from outside the visible frame, like rain, rather than
            // materializing already inside it.
            let spawnY = size.height + CGFloat.random(in: 20...160)
            // Randomized per-chip delay (not a strict left-to-right order)
            // keeps the "rain" look — chips arrive scattered in time as well
            // as in position.
            let delay = Double.random(in: 0...(Double(genres.count) * 0.06))
            let angularImpulse = CGFloat.random(in: -0.3...0.3)

            run(SKAction.wait(forDuration: delay)) { [weak self] in
                guard let self else { return }
                let chip = ChipNode(genre: genre)
                chip.position = CGPoint(x: spawnX, y: spawnY)
                chip.physicsBody?.velocity = CGVector(
                    dx: CGFloat.random(in: -6...6),
                    dy: 0
                )
                chip.physicsBody?.applyAngularImpulse(angularImpulse)
                // Chips used to pop into existence at full size the
                // instant physics took over — fading and scaling them in
                // over the same beat makes each arrival read as one
                // continuous motion instead of a sudden appearance.
                chip.alpha = 0
                chip.setScale(0.6)
                let fadeIn = SKAction.fadeIn(withDuration: 0.22)
                let scaleIn = SKAction.scale(to: 1.0, duration: 0.22)
                fadeIn.timingMode = .easeOut
                scaleIn.timingMode = .easeOut
                chip.run(.group([fadeIn, scaleIn]))
                self.addChild(chip)
            }
        }
    }

    override func didFinishUpdate() {
        guard !hasRenderedFirstFrame else { return }
        hasRenderedFirstFrame = true
        onFirstFrameRendered?()
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

    // SKView defaults to an opaque background until told otherwise; setting
    // that in `layoutSubviews()` left one frame — right as this view is
    // first laid out during the push transition — where it briefly showed
    // its default (grey) color instead of the screen behind it.
    //
    // Beyond that, SpriteKit's own Metal pipeline renders an opaque grey
    // frame while it initializes, independent of `backgroundColor` — a known
    // SKView quirk, worst on a view's very first appearance. Staying
    // invisible until that first frame is actually drawn (see
    // `presentScene`'s completion below) hides it entirely instead of
    // fading it.
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor     = .clear
        allowsTransparency  = true
        ignoresSiblingOrder = true
        alpha               = 0
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard !sceneCreated, bounds.width > 0, bounds.height > 0 else { return }
        sceneCreated        = true

        let scene = GravityScene(size: bounds.size)
        scene.scaleMode          = .resizeFill
        scene.genres             = genres
        scene.onSelectionChanged = onSelectionChanged
        scene.onFirstFrameRendered = { [weak self] in
            // One more runloop tick: `didFinishUpdate` fires once SpriteKit's
            // update pass is done, just before that frame is actually handed
            // to the display — revealing right on this callback could still
            // race the real grey-to-content swap by a hair.
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.15) {
                    self?.alpha = 1
                }
            }
        }
        presentScene(scene)
        gravityScene = scene

        // Chips should all fall straight down and settle first — only then
        // does the ceiling collider engage and gravity start following the
        // device's tilt. Enabling either immediately raced the drop
        // animation: a chip could still be spawning above the (not yet
        // existing) ceiling, or the whole pile could veer sideways mid-drop
        // if the device wasn't held perfectly level.
        let maxSpawnDelay = Double(genres.count) * 0.06
        // The board now spans the full screen (chips fall from behind the
        // title instead of a shorter strip below it), so each chip has
        // further to drop — give it more time to actually land.
        let settleBuffer = 2.4
        DispatchQueue.main.asyncAfter(deadline: .now() + maxSpawnDelay + settleBuffer) { [weak self] in
            self?.gravityScene?.enableCeilingCollider()
            self?.startFollowingDeviceTilt()
        }
    }

    // Points gravity toward whichever edge is physically "down" — upright falls
    // down, rotated right falls right — so the pile stays believable through
    // any device rotation without depending on the interface orientation.
    private func startFollowingDeviceTilt() {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, _ in
            guard let self, let acceleration = data?.acceleration else { return }
            let magnitude: CGFloat = 6
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
