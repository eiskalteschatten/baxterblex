//
//  MacCharacterAttributeEditor.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

struct MacCharacterAttributeEditor: View {
    @Environment(\.dismiss) var dismiss
    
    var character: Character
    
    @State private var selectedType: CharacterAttributeType?
    @State private var selectedCategory: CharacterAttributeCategory?
    @State private var selectedAttribute: CharacterAttribute?
    
    @FetchRequest private var types: FetchedResults<CharacterAttributeType>
    
    init(character: Character) {
        self.character = character
        
        self._types = FetchRequest<CharacterAttributeType>(
            sortDescriptors: [NSSortDescriptor(keyPath: \CharacterAttributeType.name, ascending: true)],
            predicate: NSPredicate(format: "character == %@", character),
            animation: .default
        )
    }
    
    var body: some View {
        VStack {
            HSplitView {
                List(types, id: \.self, selection: $selectedType) { type in
                    Text(type.name ?? "")
                }
                
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
        let context = PersistenceController.preview.container.viewContext
        let character = context.registeredObjects.first(where: { $0 is Character }) as! Character
        
        MacCharacterAttributeEditor(character: character)
    }
}
