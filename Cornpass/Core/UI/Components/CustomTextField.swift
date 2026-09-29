//
//  CustomTextField.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

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

// MARK: PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    CustomTextField(
        title: "Email",
        text: .constant("muhammednadeem989@gmail.com"),
        isSecured: true
    )
}
