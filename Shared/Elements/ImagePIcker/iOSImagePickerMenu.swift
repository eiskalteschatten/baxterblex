//
//  iOSImagePickerMenu.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 29.05.22.
//

import SwiftUI

struct iOSImagePickerMenu: View {
    @State private var presentImagePicker = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var image = UIImage()
    
    @Binding var imageStore: ImageStore?
    
    var body: some View {
        Menu {
            Button(action: {
                imagePickerSourceType = .photoLibrary
                presentImagePicker = true
            }) {
                Label("Choose Image", systemImage: "photo")
            }
            
            Button(action: {
                imagePickerSourceType = .camera
                presentImagePicker = true
            }) {
                Label("Take a Picture", systemImage: "viewfinder")
            }
        } label: {
            if let unwrappedImageStore = imageStore, let bookcover = unwrappedImageStore.image {
                let image = UIImage(data: bookcover)
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
            }
            else {
                Image(systemName: "plus.square.dashed")
                    .font(.system(size: 150))
                    .foregroundColor(.primary)
            }
        }
        .sheet(isPresented: $presentImagePicker) {
            iOSImagePicker(
                sourceType: imagePickerSourceType,
                selectedImage: $image,
                selectedImageStore: $imageStore
            )
        }
    }
}
