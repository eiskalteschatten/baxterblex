//
//  iOSCharacterAttributeEditor.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 02.06.22.
//

import SwiftUI

struct iOSCharacterAttributeEditor: View {
    var character: Character
    private var game: Game
    
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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct iOSCharacterAttributeEditor_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let character = context.registeredObjects.first(where: { $0 is Character }) as! Character
        
        iOSCharacterAttributeEditor(character: character)
    }
}
