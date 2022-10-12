//
//  CategoryIconSelectorView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 16.01.2022.
//

import SwiftUI
import OrderedCollections

class UIEmojiTextField: UITextField {

   override func awakeFromNib() {
      super.awakeFromNib()
      self.tintColor = .clear
   }

   override init(frame: CGRect) {
      super.init(frame: frame)
      self.tintColor = .clear
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

   func setEmoji() {
      _ = self.textInputMode
   }

   override var textInputContextIdentifier: String? {
      return ""
   }

   override var textInputMode: UITextInputMode? {
      for mode in UITextInputMode.activeInputModes {
         if mode.primaryLanguage == "emoji" {
            self.keyboardType = .default // do not remove this
            return mode
         }
      }
      return nil
   }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""

    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }

    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField

        init(parent: EmojiTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

extension String {
    func onlyEmoji() -> String {
        return self.filter({$0.isEmoji})
    }
}

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}

struct CategoryIconSelectorView: View {

   @Binding private(set) var icons: OrderedDictionary<Category.Icon, Bool>

   private let grid = [
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible())
   ]

   @Binding var emojiText: String
   @State var emojiIconSelected: Bool = false
   @FocusState private var emojiIsFocused: Bool

   var body: some View {
      ZStack {
         EmojiTextField(text: $emojiText, placeholder: "")
            .modifier(EmojiOnly(text: $emojiText))
            .onReceive(emojiText.publisher.collect(), perform: {
               if let last = $0.last { emojiText = String(last) }
            })
            .focused($emojiIsFocused)
            .frame(width: 100, height: 0, alignment: .top) // workaround to hide the field
            .tint(.clear)

         LazyVGrid(columns: grid) {
            CategoryIconView(
               isSelected: emojiIconSelected,
               icon: Image(systemName: "face.smiling"),
               bgColor: .init(hex: 0x12D8FA).opacity(0.2)
            )
            .frame(width: 44, height: 44, alignment: .center)
            .onTapGesture {
               emojiIsFocused = true
               emojiIconSelected = true
               icons.forEach {
                  icons[$0.key] = false
               }
            }

            ForEach(icons.keys) { iconName in
               let isSelected = icons[iconName] ?? false
               CategoryIconView(
                  isSelected: isSelected,
                  icon: iconName.img,
                  bgColor: BonsaiColor.card
               )
               .frame(width: 44, height: 44, alignment: .center)
               .onTapGesture {
                  emojiIconSelected = false
                  emojiIsFocused = false
                  emojiText = ""
                  icons.forEach {
                     if $0.key == iconName {
                        if $0.value == false {
                           icons[$0.key] = true
                        }
                     } else if $0.value == true {
                        icons[$0.key] = false
                     }
                  }
               }
            }
         } // LazyVGrid
         .background(BonsaiColor.card)
      }
      .padding(8)
      .frame(maxHeight: .infinity)
      .background(BonsaiColor.card)
   }
}

struct CategoryIconSelectorView_Previews: PreviewProvider {

   static var icons = Category.Icon.allCases.reduce(OrderedDictionary<Category.Icon, Bool>())
   { partialResult, icon in
      var res = partialResult
      res[icon] = false
      return res
   }

   static var previews: some View {
      CategoryIconSelectorView(
         icons: .constant(icons), emojiText: .constant("")
      )
         .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
         .previewDisplayName("iPhone 12")
   }
}
