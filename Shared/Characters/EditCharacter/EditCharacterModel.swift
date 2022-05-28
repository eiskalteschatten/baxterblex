//
//  EditCharacterModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

final class EditCharacterModel: AbstractEditModel {
    var character: Character!
    private var game: Game?
    private var shouldSave = false
    
    @Published var name: String = "" {
        didSet { saveAfterEdit() }
    }
    
    @Published var picture: Data? {
        didSet { saveAfterEdit() }
    }
    
    @Published var age: String = "" {
        didSet { saveAfterEdit() }
    }
    
    @Published var biography = NSAttributedString(string: "") {
        didSet { saveAfterEdit() }
    }
    
    @Published var familyFriends = NSAttributedString(string: "") {
        didSet { saveAfterEdit() }
    }
    
    @Published var hobbies = NSAttributedString(string: "") {
        didSet { saveAfterEdit() }
    }
    
    @Published var notes = NSAttributedString(string: "") {
        didSet { saveAfterEdit() }
    }
    
    @Published var occupation = NSAttributedString(string: "") {
        didSet { saveAfterEdit() }
    }
    
    init(character: Character? = nil) {
        super.init()
        self.character = character ?? Character(context: viewContext!)
        
        if character != nil {
            initVariables()
        }
        
        self.shouldSave = true
    }
    
    override func initVariables() {
        name = character.name ?? name
        picture = character.picture
        age = character.age ?? age
        biography = character.biography ?? biography
        familyFriends = character.familyFriends ?? familyFriends
        hobbies = character.hobbies ?? hobbies
        notes = character.notes ?? notes
        occupation = character.occupation ?? occupation
    }
    
    private func saveAfterEdit() {
        if shouldSave {
            DispatchQueue.main.async() { self.save() }
        }
    }
    
    override func save() {
//        if game == nil {
//            // TODO: throw a non-fatal error after error handling is built-in
//            fatalError("The game is not set when trying to save a character")
//        }
        
        withAnimation {
            character.createdAt = Date()
            character.updatedAt = Date()
            
            character.name = name
            character.age = age
            character.biography = biography
            character.familyFriends = familyFriends
            character.hobbies = hobbies
            character.notes = notes
            character.occupation = occupation
            
            if let unwrappedGame = game {
                character.game = unwrappedGame
            }
            
            if let unwrappedPicture = picture {
                character.picture = unwrappedPicture
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
