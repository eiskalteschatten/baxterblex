//
//  MacMacEditCharacterAttributeListItem.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 02.06.22.
//

import SwiftUI

struct MacEditCharacterAttributeListItem: View {
    @ObservedObject var attribute: CharacterAttribute
    @Binding var selectedAttribute: CharacterAttribute?
    @Binding var attributeModel: EditCharacterAttributeModel
    
    @State private var showAttributePopover = false
    
    var body: some View {
        HStack {
            Text(attribute.name ?? "")
            
            Spacer()
            
            if attribute == selectedAttribute {
                Button {
                    showAttributePopover.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                .buttonStyle(.plain)
                .popover(isPresented: $showAttributePopover, attachmentAnchor: .point(.leading), arrowEdge: .leading) {
                    MacEditCharacterAttributePopover(attributeModel: $attributeModel)
                }
            }
        }
    }
}
