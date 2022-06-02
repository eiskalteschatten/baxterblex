//
//  EditCharacterAttributeTypeModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI

final class EditCharacterAttributeTypeModel: AbstractEditModel {
    var game: Game
    var type: CharacterAttributeType!
    
    @Published var name: String = "" {
        didSet { DispatchQueue.main.async() { self.save() } }
    }
    
    init(game: Game, type: CharacterAttributeType? = nil) {
        self.game = game
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
            type.game = game

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
    
    func deleteType() {
        withAnimation {
            viewContext!.delete(type)

            do {
                try viewContext!.save()
            } catch {
                // TODO
//                handleCoreDataError(error as NSError)
            }
        }
    }
    
    #if os(macOS)
    func promptToDelete() {
        let alert = NSAlert()
        alert.messageText = "Are you sure you want to delete this character attribute type?"
        alert.informativeText = "All of the attributes and categires within this type will also be deleted."
        alert.addButton(withTitle: "No")
        alert.addButton(withTitle: "Yes")
        alert.alertStyle = .warning
        
        let delete = alert.runModal() == NSApplication.ModalResponse.alertSecondButtonReturn
        
        if delete {
            deleteType()
        }
    }
    #endif
}


