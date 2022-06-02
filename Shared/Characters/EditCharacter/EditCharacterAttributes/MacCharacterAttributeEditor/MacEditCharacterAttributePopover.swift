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
        }
        .frame(width: 200)
        .padding(10)
    }
}
