//
//  EditCharacterView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct EditCharacterView: View {
    var character: Character?
    
    @ObservedObject private var editCharacterModel: EditCharacterModel
    
    init(character: Character? = nil) {
        self.editCharacterModel = EditCharacterModel(character: character)
        self.character = character
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $editCharacterModel.name)
            }
        }
    }
}

struct EditCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        EditCharacterView()
    }
}
