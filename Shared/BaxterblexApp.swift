//
//  BaxterblexApp.swift
//  Shared
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

@main
struct BaxterblexApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var gameStore = GameStore()

    var body: some Scene {
        WindowGroup {
            GameView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(gameStore)
        }
        #if os(macOS)
        .commands {
            SidebarCommands()
        }
        #endif
    }
}
