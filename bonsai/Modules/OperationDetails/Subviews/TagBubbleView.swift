//
//  TagBubbleView.swift
//  bonsai
//
//  Created by Vladimir Korolev on 23.01.2022.
//

import SwiftUI

extension TagBubbleView {
    
    enum Kind: Hashable {
        case tag (Tag, closeHandler: () -> Void)
        case newTagButton(touchHandler: () -> Void)
        
        static func == (lhs: TagBubbleView.Kind, rhs: TagBubbleView.Kind) -> Bool {
            switch (lhs, rhs) {
            case (.newTagButton, .newTagButton):
                return true
            case (.tag(let lhsTag, _), .tag(let rhsTag, _)):
                return lhsTag == rhsTag
            default:
                return false
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .tag(let tag, _):
                hasher.combine(tag)
            case .newTagButton:
                hasher.combine("newTagButton")
            }
        }
    }
}

struct TagBubbleView: View {
    private(set) var kind: Kind
    
    var body: some View {
        Button(action: {
            if case .newTagButton(let touchHandler) = kind {
                touchHandler()
            }
        }) {
            ZStack {
                BonsaiColor.disabled
                
                HStack(spacing: 10) {
                    
                    Text({ () -> String in
                        switch kind {
                        case .tag(let tag, _):
                            return tag.title
                        case .newTagButton:
                            return L.Operation.addTag
                        }
                    }())
                    .font(BonsaiFont.body_15)
                    .foregroundColor({ () -> Color in
                        switch (kind) {
                        case (.newTagButton):
                            return BonsaiColor.green
                        case (.tag):
                            return BonsaiColor.text
                        }
                    }())
                    .lineLimit(1)
                    
                    if case .newTagButton = kind {
                        BonsaiImage.plus
                            .renderingMode(.template)
                            .foregroundColor(BonsaiColor.green)
                    }
                    
                    if case .tag(_, let closeHandler) = kind {
                        Button(action: closeHandler) {
                            BonsaiImage.xMark
                                .renderingMode(.template)
                                .foregroundColor(BonsaiColor.text)
                        }
                    }
                    
                } // HStack
                .padding(8)
            }
        }
    }
}

struct TagBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        TagBubbleView(
            kind: .tag(Tag(
                context: DataController.sharedInstance.container.viewContext,
                title: "Health"
            ), closeHandler: {})
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("iPhone 13")
    }
}
