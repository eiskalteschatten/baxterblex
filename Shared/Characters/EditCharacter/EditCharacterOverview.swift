//
//  EditCharacterOverview.swift
//  Baxterblex
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct EditCharacterOverview: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var editCharacterModel: EditCharacterModel
    
    var body: some View {
        let textEditorHeight: CGFloat = 200
        
        ScrollView {
            VStack(spacing: 30) {
                #if os(iOS)
                iOSImagePickerMenu(imageStore: $editCharacterModel.picture)
                #else
                Button(action: pickImage) {
                    if let imageStore = editCharacterModel.picture, let picture = imageStore.image {
                        #if os(macOS)
                        let image = NSImage(data: picture)
                        Image(nsImage: image!)
                            .resizable()
                            .scaledToFit()
                        #else
                        let image = UIImage(data: picture)
                        Image(uiImage: image!)
                            .resizable()
                            .scaledToFit()
                        #endif
                    }
                    else {
                        Image(systemName: "plus.square.dashed")
                            .font(.system(size: 150))
                    }
                }
                .buttonStyle(.plain)
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
    
    private func pickImage() {
        #if os(macOS)
        let imagePicker = MacImagePicker.pickImage()
        if imagePicker.response == .OK {
            if let url = imagePicker.panel.url {
                do {
                    let data = try Data(contentsOf: url)
                    
                    if let imageStore = editCharacterModel.picture {
                        imageStore.image = data
                        imageStore.updatedAt = Date()
                    }
                    else {
                        let imageStore = ImageStore(context: viewContext)
                        imageStore.image = data
                        imageStore.updatedAt = Date()
                        imageStore.createdAt = Date()
                        editCharacterModel.picture = imageStore
                    }
                } catch {
                    // TODO!
//                    showErrorAlert(
//                        error: error as NSError,
//                        errorMessage: "An error occurred while choosing an image!",
//                        subErrorMessage: "Please try again.",
//                        logger: Logger(
//                            subsystem: Bundle.main.bundleIdentifier!,
//                            category: String(describing: EditCharacterOverview.self)
//                        )
//                    )
                }
            }
        }
        #else
        
        #endif
    }
}

struct EditCharacterOverview_Previews: PreviewProvider {
    @ObservedObject static private var editCharacterModel = EditCharacterModel(game: Game())
    
    static var previews: some View {
        EditCharacterOverview(editCharacterModel: editCharacterModel)
    }
}
