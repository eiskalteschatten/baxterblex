//
//  EditCharacterAttributes.swift
//  Baxterblex
//
//  Created by Alex Seifert on 31.05.22.
//

import SwiftUI

struct EditCharacterAttributes: View {
    @ObservedObject var editCharacterModel: EditCharacterModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditCharacterAttributes_Previews: PreviewProvider {
    @ObservedObject static private var editCharacterModel = EditCharacterModel(game: Game())
    
    static var previews: some View {
        EditCharacterAttributes(editCharacterModel: editCharacterModel)
    }
}
