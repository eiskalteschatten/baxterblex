//
//  MacImagePickerButton.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 29.05.22.
//

import SwiftUI

struct MacImagePickerButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var imageStore: ImageStore?
    
    var body: some View {
        Button(action: pickImage) {
            if let unwrappedImageStore = imageStore, let picture = unwrappedImageStore.image {
                let image = NSImage(data: picture)
                Image(nsImage: image!)
                    .resizable()
                    .scaledToFit()
            }
            else {
                Image(systemName: "plus.square.dashed")
                    .font(.system(size: 150))
            }
        }
        .buttonStyle(.plain)
    }
    
    private func pickImage() {
        let imagePicker = MacImagePicker.pickImage()
        if imagePicker.response == .OK {
            if let url = imagePicker.panel.url {
                do {
                    let data = try Data(contentsOf: url)
                    
                    if let unwrappedImageStore = imageStore {
                        unwrappedImageStore.image = data
                        unwrappedImageStore.updatedAt = Date()
                    }
                    else {
                        let newImageStore = ImageStore(context: viewContext)
                        newImageStore.image = data
                        newImageStore.updatedAt = Date()
                        newImageStore.createdAt = Date()
                        imageStore = newImageStore
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
    }
}
