//
//  EditCharacterModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

final class EditCharacterModel: AbstractEditModel {
    private var character: Character?
    
    @Published var name: String = DEFAULT_CHARACTER_NAME
    @Published var picture: Data?
    
    init(character: Character? = nil) {
        super.init()
        self.character = character
        initVariables()
    }
    
    override func initVariables() {
        if let unwrapped = character {
            name = unwrapped.name ?? name
            picture = unwrapped.picture
        }
    }
    
    override func save() {
        withAnimation {
            character = character != nil ? character : Character(context: viewContext!)
            
            character!.createdAt = Date()
            character!.updatedAt = Date()
            
            character!.name = name
            character!.picture = picture

            do {
                try viewContext!.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
