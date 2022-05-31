//
//  EditCharacterAttributes.swift
//  Baxterblex
//
//  Created by Alex Seifert on 31.05.22.
//

import SwiftUI

struct EditCharacterAttributes: View {
    @ObservedObject var editCharacterModel: EditCharacterModel
    
    @State private var showAttributeEditorSheet = false
    
    var body: some View {
        VStack {
            Button("Edit Character Attributes", action: { showAttributeEditorSheet.toggle() })
        }
        .sheet(isPresented: $showAttributeEditorSheet) {
            CharacterAttributeEditorSheet()
        }
    }
}

struct EditCharacterAttributes_Previews: PreviewProvider {
    @ObservedObject static private var editCharacterModel = EditCharacterModel(game: Game())
    
    static var previews: some View {
        EditCharacterAttributes(editCharacterModel: editCharacterModel)
    }
}
