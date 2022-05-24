//
//  GameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

enum GameViewTabs: Int {
    case games, dashboard, characters, gear, accounting, sessions
}

struct GameView: View {
    @EnvironmentObject private var gameStore: GameStore
    
    var game: Game
    
    var body: some View {
        Group {
            #if os(iOS)
            iOSGameTabView()
                .navigationTitle(game.name ?? DEFAULT_GAME_NAME)
            #else
            MacGameTabView()
                .navigationTitle(game.name ?? DEFAULT_GAME_NAME)
            #endif
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
