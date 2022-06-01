//
//  EditCharacterAttributeCategoryModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

final class EditCharacterAttributeCategoryModel: AbstractEditModel {
    var type: CharacterAttributeType
    var category: CharacterAttributeCategory!
    
    @Published var name: String = ""
    
    init(type: CharacterAttributeType, category: CharacterAttributeCategory? = nil) {
        self.type = type
        super.init()
        self.category = category ?? CharacterAttributeCategory(context: viewContext!)
        
        if category != nil {
            initVariables()
        }
    }
    
    override func initVariables() {
        name = category.name ?? name
    }
    
    override func save() {
        withAnimation {
            category.createdAt = Date()
            category.updatedAt = Date()
            category.type = type

            category.name = name

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



