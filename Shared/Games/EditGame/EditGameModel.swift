//
//  EditGameModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI
import CoreData

final class EditGameModel: ObservableObject {
    private var viewContext: NSManagedObjectContext?
    private var game: Game?
    
    @Published var name: String = ""
    @Published var addStartDate: Bool = false
    @Published var startDate: Date = Date()
    @Published var addEndDate: Bool = false
    @Published var endDate: Date = Date()
    
    init(game: Game? = nil) {
        let persistenceController = PersistenceController.shared
        viewContext = persistenceController.container.viewContext
        self.game = game
        initVariables()
    }
    
    private func initVariables() {
        if let unwrapped = game {
            name = unwrapped.name ?? name
            addStartDate = unwrapped.startDate != nil
            startDate = unwrapped.startDate ?? startDate
            addEndDate = unwrapped.endDate != nil
            endDate = unwrapped.endDate ?? endDate
        }
    }
    
    func save() {
        withAnimation {
            let newGame = Game(context: viewContext!)
            newGame.createdAt = Date()
            newGame.updatedAt = Date()
            
            newGame.name = name
            newGame.startDate = startDate
            newGame.endDate = endDate

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
}
