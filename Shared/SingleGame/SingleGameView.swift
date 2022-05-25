//
//  SingleGameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct SingleGameView: View {
    @EnvironmentObject var gameStore: GameStore
    
    var body: some View {
        Group {
            #if os(iOS)
            iOSSingleGameView()
            #else
            MacSingleGameView()
            #endif
        }
        .sheet(isPresented: $gameStore.showEditGameSheet) {
            EditGameSheet(game: gameStore.selectedGame)
        }
    }
}

struct SingleGameView_Previews: PreviewProvider {
    static var previews: some View {
        SingleGameView()
    }
}
