//
//  ContentView.swift
//  Shared
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var gameStore = GameStore()

    var body: some View {
        if let game = gameStore.selectedGame {
            GameView(game: game)
                .environmentObject(gameStore)
        }
        else {
            GamesListView()
                .environmentObject(gameStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
