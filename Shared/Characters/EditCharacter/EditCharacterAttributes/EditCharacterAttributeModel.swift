//
//  EditCharacterAttributeModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

final class EditCharacterAttributeModel: AbstractEditModel {
    var category: CharacterAttributeCategory
    var attribute: CharacterAttribute!
    
    @Published var name: String = ""
    @Published var notes: String = ""
    @Published var starred = false
    @Published var value: Int?
    
    init(category: CharacterAttributeCategory, attribute: CharacterAttribute? = nil) {
        self.category = category
        super.init()
        self.attribute = attribute ?? CharacterAttribute(context: viewContext!)
        
        if attribute != nil {
            initVariables()
        }
    }
    
    override func initVariables() {
        name = attribute.name ?? name
        notes = attribute.notes ?? notes
        starred = attribute.starred
        value = attribute.value?.intValue ?? value
    }
    
    override func save() {
        withAnimation {
            attribute.createdAt = Date()
            attribute.updatedAt = Date()
            attribute.category = category

            attribute.name = name
            attribute.notes = notes
            attribute.starred = starred
            
            if let unwrapped = value {
                attribute.value = NSNumber(value: unwrapped)
            }

            do {
                try viewContext!.save()
            } catch {
                // TODO
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
//    static func deleteCharacter(_ character: Character) {
//        withAnimation {
//            let viewContext = PersistenceController.shared.container.viewContext
//            viewContext.delete(character)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // TODO
////                handleCoreDataError(error as NSError)
//            }
//        }
//    }
}

