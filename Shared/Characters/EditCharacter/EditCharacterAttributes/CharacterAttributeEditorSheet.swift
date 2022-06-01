//
//  CharacterAttributeEditorSheet.swift
//  Baxterblex
//
//  Created by Alex Seifert on 31.05.22.
//

import SwiftUI

struct CharacterAttributeEditorSheet: View {
    @EnvironmentObject private var gameStore: GameStore
    
    var body: some View {
        if let character = gameStore.selectedCharacter {
            #if os(macOS)
            MacCharacterAttributeEditor(character: character)
            #else
            // TODO
            #endif
        }
        else {
            Text("No character selected")
        }
    }
}

struct CharacterAttributeEditorSheet_Previews: PreviewProvider {
    static var previews: some View {
        CharacterAttributeEditorSheet()
    }
}
