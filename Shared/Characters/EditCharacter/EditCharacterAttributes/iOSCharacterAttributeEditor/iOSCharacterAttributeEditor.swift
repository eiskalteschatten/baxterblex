//
//  iOSCharacterAttributeEditor.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 02.06.22.
//

import SwiftUI

struct iOSCharacterAttributeEditor: View {
    @Environment(\.dismiss) var dismiss
    
    var character: Character
    private var game: Game
    
    @State private var selectedType: CharacterAttributeType?
    
    @FetchRequest private var types: FetchedResults<CharacterAttributeType>
    
    init(character: Character) {
        self.character = character
        self.game = character.game!
        
        self._types = FetchRequest<CharacterAttributeType>(
            sortDescriptors: [NSSortDescriptor(keyPath: \CharacterAttributeType.name, ascending: true)],
            predicate: NSPredicate(format: "game == %@", game),
            animation: .default
        )
    }
    
    var body: some View {
        NavigationView {
            List(types, id: \.self, selection: $selectedType) { type in
                NavigationLink(
                    destination: Text(type.name ?? ""),
                    tag: type,
                    selection: $selectedType,
                    label: { Text(type.name ?? "") }
                )
            }
            .navigationBarTitle("Edit Character Attributes", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                    }
                )
        }
        .navigationViewStyle(.stack)
    }
}

struct iOSCharacterAttributeEditor_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let character = context.registeredObjects.first(where: { $0 is Character }) as! Character
        
        iOSCharacterAttributeEditor(character: character)
    }
}
