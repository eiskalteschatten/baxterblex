//
//  EditCharacterOverview.swift
//  Baxterblex
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct EditCharacterOverview: View {
    @ObservedObject var editCharacterModel: EditCharacterModel
    
    var body: some View {
        VStack {
            TextField("Name", text: $editCharacterModel.name)
            
            Text("Biography")
            RichTextEditor(text: $editCharacterModel.biography)
        }
    }
}

struct EditCharacterOverview_Previews: PreviewProvider {
    @ObservedObject static private var editCharacterModel = EditCharacterModel()
    
    static var previews: some View {
        EditCharacterOverview(editCharacterModel: editCharacterModel)
    }
}
