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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #if os(macOS)
        .commands {
            SidebarCommands()
            TextEditingCommands()
//            TextFormattingCommands()
        }
        #endif
    }
}
