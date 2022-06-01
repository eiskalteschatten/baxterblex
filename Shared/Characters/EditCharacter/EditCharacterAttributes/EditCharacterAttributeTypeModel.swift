//
//  EditCharacterAttributeTypeModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

final class EditCharacterAttributeTypeModel: AbstractEditModel {
    var type: CharacterAttributeType!
    
    @Published var name: String = ""
    
    init(type: CharacterAttributeType? = nil) {
        super.init()
        self.type = type ?? CharacterAttributeType(context: viewContext!)
        
        if type != nil {
            initVariables()
        }
    }
    
    override func initVariables() {
        name = type.name ?? name
    }
    
    override func save() {
        withAnimation {
            type.createdAt = Date()
            type.updatedAt = Date()

            type.name = name

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


