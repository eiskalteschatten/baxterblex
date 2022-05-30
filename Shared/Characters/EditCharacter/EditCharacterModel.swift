//
//  EditCharacterModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

enum CharacterStatuses: String, CaseIterable, Identifiable {
    case draft = "draft"
    case active = "active"
    case inactive = "inactive"
    case dead = "dead"
    
    var id: Self { self }
}

let characterStatusLabels: [CharacterStatuses: String] = [
    .draft: "Draft",
    .active: "Active",
    .inactive: "Inactive",
    .dead: "Dead"
]

final class EditCharacterModel: AbstractEditModel {
    var character: Character!
    private var game: Game
    private var shouldSave = false
    
    @Published var name: String = "" {
        didSet { saveAfterEdit() }
    }
    
    @Published var picture: ImageStore? {
        didSet { saveAfterEdit() }
    }
    
    @Published var age: String = "" {
        didSet { saveAfterEdit() }
    }
    
    @Published var status: CharacterStatuses = .draft {
        didSet { saveAfterEdit() }
    }
    
//    @Published var biography = NSAttributedString(string: "") {
    @Published var biography: String = "" {
        didSet { saveAfterEdit() }
    }
    
//    @Published var familyFriends = NSAttributedString(string: "") {
    @Published var familyFriends: String = "" {
        didSet { saveAfterEdit() }
    }
    
//    @Published var hobbies = NSAttributedString(string: "") {
    @Published var hobbies: String = "" {
        didSet { saveAfterEdit() }
    }
    
//    @Published var notes = NSAttributedString(string: "") {
    @Published var notes: String = "" {
        didSet { saveAfterEdit() }
    }
    
//    @Published var occupation = NSAttributedString(string: "") {
    @Published var occupation: String = "" {
        didSet { saveAfterEdit() }
    }
    
    init(game: Game, character: Character? = nil) {
        self.game = game
        super.init()
        self.character = character ?? Character(context: viewContext!)
        
        if character != nil {
            initVariables()
            
            // Set shouldSave here on iOS because a new character should only be created
            // when clicking on the "Save" button in the new character sheet
            #if os(iOS)
            self.shouldSave = true
            #endif
        }
        
        // Set shouldSave here on macOS because it should always save after initializing
        #if os(macOS)
        self.shouldSave = true
        #endif
    }
    
    override func initVariables() {
        picture = character.picture
        name = character.name ?? name
        picture = character.picture
        age = character.age ?? age
        status = character.status != nil ? CharacterStatuses(rawValue: character.status!)! : status
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
        withAnimation {
            character.createdAt = Date()
            character.updatedAt = Date()
            character.game = game
            
            character.name = name
            character.age = age
            character.status = status.rawValue
            character.biography = biography
            character.familyFriends = familyFriends
            character.hobbies = hobbies
            character.notes = notes
            character.occupation = occupation
            
            if let unwrappedPicture = picture {
                character.picture = unwrappedPicture
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
    
    func setGame(_ game: Game) {
        self.game = game
    }
    
    private func getPictureImageStore(data: Data) -> ImageStore {
        if let unwrappedImage = character.picture {
            unwrappedImage.updatedAt = Date()
            unwrappedImage.image = data
            return unwrappedImage
        }
        else {
            let image = ImageStore(context: viewContext!)
            image.createdAt = Date()
            image.updatedAt = Date()
            image.image = data
            return image
        }
    }
    
    static func deleteCharacter(_ character: Character) {
        withAnimation {
            let viewContext = PersistenceController.shared.container.viewContext
            viewContext.delete(character)
            
            do {
                try viewContext.save()
            } catch {
                // TODO
//                handleCoreDataError(error as NSError)
            }
        }
    }
    
}
