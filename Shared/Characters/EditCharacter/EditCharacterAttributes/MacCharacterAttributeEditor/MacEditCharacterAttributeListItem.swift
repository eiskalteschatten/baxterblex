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
    
    @State private var showAttributePopover = false
    
    var body: some View {
        HStack {
            Text(attribute.name ?? "")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .popover(isPresented: $showAttributePopover) {
            MacEditCharacterAttributePopover()
        }
        .onChange(of: selectedAttribute) { newAttribute in
            showAttributePopover = attribute == newAttribute
        }
    }
}

struct MacEditCharacterAttributeListItem_Previews: PreviewProvider {
    @State static private var selectedAttribute: CharacterAttribute?
    
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let attribute = context.registeredObjects.first(where: { $0 is CharacterAttribute }) as! CharacterAttribute
        
        MacEditCharacterAttributeListItem(attribute: attribute, selectedAttribute: $selectedAttribute)
    }
}
