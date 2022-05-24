//
//  GameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

enum GameViewTabs: Int {
    case dashboard, characters, gear, accounting, sessions
}

struct GameView: View {
    var game: Game
    
    @StateObject private var gameStore = GameStore()
    
    var body: some View {
        Group {
            #if os(iOS)
            iOSGameTabView()
                .environmentObject(gameStore)
                .navigationTitle(game.name ?? DEFAULT_GAME_NAME)
            #else
            MacGameTabView()
                .environmentObject(gameStore)
                .navigationTitle(game.name ?? DEFAULT_GAME_NAME)
            #endif
        }
        .onAppear {
            gameStore.selectedGame = game
        }
        .onDisappear {
            gameStore.selectedGame = nil
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        GameView(game: game)
    }
}
