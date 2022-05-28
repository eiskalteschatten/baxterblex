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
        let textEditorHeight: CGFloat = 200
        
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                TextField("Name", text: $editCharacterModel.name)
                
                VStack(alignment: .leading) {
                    Text("Biography")
                    RichTextEditor(text: $editCharacterModel.biography)
                        .frame(height: textEditorHeight)
                }
                
                VStack(alignment: .leading) {
                    Text("Family & Friends")
                    RichTextEditor(text: $editCharacterModel.familyFriends)
                        .frame(height: textEditorHeight)
                }
                
                VStack(alignment: .leading) {
                    Text("Hobbies")
                    RichTextEditor(text: $editCharacterModel.hobbies)
                        .frame(height: textEditorHeight)
                }
                
                VStack(alignment: .leading) {
                    Text("Occupation")
                    RichTextEditor(text: $editCharacterModel.occupation)
                        .frame(height: textEditorHeight)
                }
                
                VStack(alignment: .leading) {
                    Text("Notes")
                    RichTextEditor(text: $editCharacterModel.notes)
                        .frame(height: textEditorHeight)
                }
            }
        }
    }
}

struct EditCharacterOverview_Previews: PreviewProvider {
    @ObservedObject static private var editCharacterModel = EditCharacterModel()
    
    static var previews: some View {
        EditCharacterOverview(editCharacterModel: editCharacterModel)
    }
}
