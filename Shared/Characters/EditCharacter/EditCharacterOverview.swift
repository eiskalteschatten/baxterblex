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
            VStack(spacing: 30) {
                #if os(iOS)
                iOSImagePickerMenu(imageStore: $editCharacterModel.picture)
                #else
                MacImagePickerButton(imageStore: $editCharacterModel.picture)
                    .frame(maxHeight: 300)
                #endif
                
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Name", text: $editCharacterModel.name)
                        .textFieldStyle(.plain)
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Text("Age:")
                        
                        TextField(
                            "25",
                            text: $editCharacterModel.age
                        )
                        .frame(width: 50)
                        #if os(iOS)
                        .keyboardType(.numberPad)
                        #endif
                    }
                }
                
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
                
                VStack {
                    if let createdAt = editCharacterModel.character?.createdAt {
                        Text("Created at: \(formatDateTimeLong(createdAt))")
                            .font(.caption)
                    }
                    
                    if let updatedAt = editCharacterModel.character?.updatedAt {
                        Text("Last updated at: \(formatDateTimeLong(updatedAt))")
                            .font(.caption)
                    }
                }
                .opacity(0.6)
            }
        }
    }
}

struct EditCharacterOverview_Previews: PreviewProvider {
    @ObservedObject static private var editCharacterModel = EditCharacterModel(game: Game())
    
    static var previews: some View {
        EditCharacterOverview(editCharacterModel: editCharacterModel)
    }
}
