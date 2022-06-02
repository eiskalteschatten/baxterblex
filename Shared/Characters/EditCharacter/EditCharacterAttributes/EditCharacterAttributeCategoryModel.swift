//
//  EditCharacterAttributeCategoryModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 01.06.22.
//

import SwiftUI
import CoreData

final class EditCharacterAttributeCategoryModel: AbstractEditModel {
    var type: CharacterAttributeType
    var category: CharacterAttributeCategory!
    
    @Published var name: String = "" {
        didSet { DispatchQueue.main.async() { self.save() } }
    }
    
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
    
    static func getCategoriesFromType(_ type: CharacterAttributeType) async -> [CharacterAttributeCategory] {
        let viewContext = PersistenceController.shared.container.viewContext
        
        let fetchRequest: NSFetchRequest<CharacterAttributeCategory>
        fetchRequest = CharacterAttributeCategory.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CharacterAttributeCategory.name, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "type == %@", type)
        
        do {
            return try await viewContext.perform {
                return try fetchRequest.execute()
            }
        } catch {
            // TODO: Add core data error handling
        }
        
        return []
    }
    
    func deleteCategory() {
        withAnimation {
            viewContext!.delete(category)

            do {
                try viewContext!.save()
            } catch {
                // TODO
//                handleCoreDataError(error as NSError)
            }
        }
    }
    
    #if os(macOS)
    func promptToDelete() -> Bool {
        let alert = NSAlert()
        alert.messageText = "Are you sure you want to delete this character attribute category?"
        alert.informativeText = "All of the attributes within this type will also be deleted."
        alert.addButton(withTitle: "No")
        alert.addButton(withTitle: "Yes")
        alert.alertStyle = .warning
        
        let delete = alert.runModal() == NSApplication.ModalResponse.alertSecondButtonReturn
        
        if delete {
            deleteCategory()
            return true
        }
        
        return false
    }
    #endif
}



