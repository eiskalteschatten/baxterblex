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
    
    var body: some View {
        Group {
            #if os(iOS)
            iOSGameTabView()
            #else
            MacGameTabView()
                .navigationTitle(game.name ?? DEFAULT_GAME_NAME)
            #endif
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
