//
//  Untitled.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 23/05/26.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var background: Color = .white
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.semiBold.font(size: 16))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(background)
                .clipShape(Capsule())
        }
    }
}

struct LoginActionButton: View {
    let title: String
    let image: ImageResource
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                Text(title)
                    .foregroundStyle(.white)
                    .font(AppFont.regular.font(size: 14))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color(hex: "#14181B"))
            .clipShape(Capsule())
        }
    }
}

// MARK: CUSTOM TEXT FIELD
struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let isSecured: Bool
    let keyboardType: UIKeyboardType
    @FocusState private var isFocused: Bool
    @State private var isRevealed: Bool = false

    init(title: String, text: Binding<String>, isSecured: Bool = false, keyboardType: UIKeyboardType = .default) {
        self.title = title
        self._text = text
        self.isSecured = isSecured
        self.keyboardType = keyboardType
    }

    private var isFloating: Bool {
        isFocused || !text.trimmed.isEmpty
    }

    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                ZStack(alignment: .leading) {
                    Text(title)
                        .font(isFloating ? AppFont.regular.font(size: 10) : AppFont.regular.font(size: 14))
                        .foregroundStyle(.white.opacity(0.8))
                        .offset(y: isFloating ? -10 : 0)
                        .animation(.spring(duration: 0.2), value: isFloating)
                    Group {
                        if isSecured && !isRevealed {
                            SecureField("", text: $text)
                        } else {
                            TextField("", text: $text)
                        }
                    }
                    .font(AppFont.regular.font(size: 14))
                    .foregroundStyle(.white)
                    .tint(.white)
                    .focused($isFocused)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .scrollDismissesKeyboard(.immediately)
                    .offset(y: isFloating ? 10 : 0)
                    .opacity(isFloating ? 1 : 0)
                    .animation(.spring(duration: 0.2), value: isFloating)
                }
                if isSecured {
                    Button {
                        isRevealed.toggle()
                    } label: {
                        Image(systemName: isRevealed ? "eye" : "eye.slash")
                            .foregroundStyle(.white.opacity(0.6))
                            .contentTransition(.symbolEffect(.replace))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(Color(hex: "#14181B"))
        .clipShape(Capsule())
        .onTapGesture {
            isFocused = true
        }
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        CustomTextField(
            title: "Email",
            text: .constant("muhammednadeem989@gmail.com"),
            isSecured: true
        )
        .previewLayout(.sizeThatFits)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
