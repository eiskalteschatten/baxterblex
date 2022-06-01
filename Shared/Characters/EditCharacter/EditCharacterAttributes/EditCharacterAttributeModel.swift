//
//  EditCharacterAttributeModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

final class EditCharacterAttributeModel: AbstractEditModel {
    var character: Character!
    
    @Published var name: String = ""
    
    init(character: Character) {
        super.init()
        self.character = character
        
//        initVariables()
    }
    
//    override func initVariables() {
//        picture = character.picture
//        name = character.name ?? name
//        picture = character.picture
//        age = character.age ?? age
//        status = character.status != nil ? CharacterStatuses(rawValue: character.status!)! : status
//        biography = character.biography ?? biography
//        familyFriends = character.familyFriends ?? familyFriends
//        hobbies = character.hobbies ?? hobbies
//        notes = character.notes ?? notes
//        occupation = character.occupation ?? occupation
//    }
    
    override func save() {
        withAnimation {
//            character.createdAt = Date()
//            character.updatedAt = Date()
//            character.game = game
//            
//            character.name = name
//            character.age = age
//            character.status = status.rawValue
//            character.biography = biography
//            character.familyFriends = familyFriends
//            character.hobbies = hobbies
//            character.notes = notes
//            character.occupation = occupation
//            
//            if let unwrappedPicture = picture {
//                character.picture = unwrappedPicture
//            }
            
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

