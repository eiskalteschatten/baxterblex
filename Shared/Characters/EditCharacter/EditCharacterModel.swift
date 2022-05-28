//
//  EditCharacterModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

final class EditCharacterModel: AbstractEditModel {
    var character: Character?
    private var game: Game?
    
    @Published var name: String = "" {
        didSet {
            save()
        }
    }
    
    @Published var picture: Data?
    @Published var age: Int16?
    @Published var biography = NSAttributedString(string: "")
    @Published var familyFriends = NSAttributedString(string: "")
    @Published var hobbies = NSAttributedString(string: "")
    @Published var notes = NSAttributedString(string: "")
    @Published var occupation = NSAttributedString(string: "")
    
    init(character: Character? = nil) {
        self.character = character
        super.init()
        initVariables()
    }
    
    override func initVariables() {
        if let unwrapped = character {
            name = unwrapped.name ?? name
            picture = unwrapped.picture
            age = unwrapped.age
            biography = unwrapped.biography ?? biography
            familyFriends = unwrapped.familyFriends ?? familyFriends
            hobbies = unwrapped.hobbies ?? hobbies
            notes = unwrapped.notes ?? notes
            occupation = unwrapped.occupation ?? occupation
        }
    }
    
    override func save() {
//        if game == nil {
//            // TODO: throw a non-fatal error after error handling is built-in
//            fatalError("The game is not set when trying to save a character")
//        }
        
        withAnimation {
            character = character != nil ? character : Character(context: viewContext!)
            
            character!.createdAt = Date()
            character!.updatedAt = Date()
            
            character!.name = name
            character!.biography = biography
            character!.familyFriends = familyFriends
            character!.hobbies = hobbies
            character!.notes = notes
            character!.occupation = occupation
            
            if let unwrappedGame = game {
                character!.game = unwrappedGame
            }
            
            if let unwrappedPicture = picture {
                character!.picture = unwrappedPicture
            }
            
            if let unwrappedAge = age {
                character!.age = unwrappedAge
            }

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
    
    func setGame(_ game: Game) {
        self.game = game
    }
}
