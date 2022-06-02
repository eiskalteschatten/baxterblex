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
    private var shouldSave = false
    
    @Published var name: String = "" {
        didSet { saveAfterEdit() }
    }
    
    @Published var notes: String = "" {
        didSet { saveAfterEdit() }
    }
    
    @Published var starred = false {
        didSet { saveAfterEdit() }
    }
    
    @Published var value: Int? {
        didSet { saveAfterEdit() }
    }
    
    init(category: CharacterAttributeCategory, attribute: CharacterAttribute? = nil) {
        self.category = category
        super.init()
        self.attribute = attribute ?? CharacterAttribute(context: viewContext!)
        
        if attribute != nil {
            initVariables()
            
            // Set shouldSave here on iOS because a new character should only be created
            // when clicking on the "Save" button in the new character sheet
            #if os(iOS)
            self.shouldSave = true
            #endif
        }
        
        #if os(macOS)
        self.shouldSave = true
        #endif
    }
    
    override func initVariables() {
        name = attribute.name ?? name
        notes = attribute.notes ?? notes
        starred = attribute.starred
        value = attribute.value?.intValue ?? value
    }
    
    private func saveAfterEdit() {
        if shouldSave {
            DispatchQueue.main.async() { self.save() }
        }
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
    
    static func getAttributesFromCategory(_ category: CharacterAttributeCategory) async -> [CharacterAttribute] {
        let viewContext = PersistenceController.shared.container.viewContext
        
        let fetchRequest: NSFetchRequest<CharacterAttribute>
        fetchRequest = CharacterAttribute.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CharacterAttribute.name, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        do {
            return try await viewContext.perform {
                return try fetchRequest.execute()
            }
        } catch {
            // TODO: Add core data error handling
        }
        
        return []
    }
    
    func deleteAttribute() {
        withAnimation {
            viewContext!.delete(attribute)

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
        alert.messageText = "Are you sure you want to delete this character attribute?"
        alert.informativeText = "This cannot be undone."
        alert.addButton(withTitle: "No")
        alert.addButton(withTitle: "Yes")
        alert.alertStyle = .warning
        
        let delete = alert.runModal() == NSApplication.ModalResponse.alertSecondButtonReturn
        
        if delete {
            deleteAttribute()
        }
    }
    #endif
}

