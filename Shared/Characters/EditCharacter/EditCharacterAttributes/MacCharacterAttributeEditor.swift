//
//  MacCharacterAttributeEditor.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

struct MacCharacterAttributeEditor: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HSplitView {
                Text("Types")
                
                Text("Categories")
                
                Text("Attributes")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Spacer()
                
                Button("Done") { dismiss() }
                    .keyboardShortcut(.cancelAction)
            }
        }
        .frame(minWidth: 400, minHeight: 300)
        .padding(20)
    }
}

struct MacCharacterAttributeEditor_Previews: PreviewProvider {
    static var previews: some View {
        MacCharacterAttributeEditor()
    }
}
