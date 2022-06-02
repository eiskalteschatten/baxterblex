//
//  MacEditCharacterAttributePopover.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 02.06.22.
//

import SwiftUI

struct MacEditCharacterAttributePopover: View {
    @Binding var attributeModel: EditCharacterAttributeModel
    
    var body: some View {
        Form {
            TextField("Name:", text: $attributeModel.name)
            
            Text("Notes:")
            TextEditor(text: $attributeModel.notes)
                .frame(height: 80)
        }
        .frame(width: 300)
        .padding(15)
    }
}
