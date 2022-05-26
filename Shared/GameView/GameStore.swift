//
//  GameStore.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI
import CoreData

final class GameStore: ObservableObject {
    // Games
    @Published var selectedGame: Game?
    @Published var showEditGameSheet = false
    
    func setSelectedGameFromURL(url: URL, viewContext: NSManagedObjectContext) {
        if let objectID = viewContext.persistentStoreCoordinator!.managedObjectID(forURIRepresentation: url),
           let game = try? viewContext.existingObject(with: objectID) as? Game {
            selectedGame = game
        }
    }
    
    // Characters
    @Published var selectedCharacter: Character?
    @Published var showCreateCharacterScreen: Bool? = false
}
