//
//  GameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

enum GameViewTabs: Int {
    case game, dashboard, characters, gear, accounting, sessions
}

struct GameView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @SceneStorage("selectedGameURL") private var selectedGameURL: URL?
    
    @StateObject private var gameStore = GameStore()
    
    var body: some View {
        Group {
            #if os(iOS)
            iOSGameTabView()
                .environmentObject(gameStore)
            #else
            MacGameTabView()
                .environmentObject(gameStore)
                .navigationTitle(gameStore.selectedGame?.name ?? "Baxterblex")
            #endif
        }
        .onChange(of: selectedGameURL) { gameURL in
            if let url = gameURL {
                gameStore.setSelectedGameFromURL(url: url, viewContext: viewContext)
            }
        }
        .onAppear {
            if let url = selectedGameURL {
                gameStore.setSelectedGameFromURL(url: url, viewContext: viewContext)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
