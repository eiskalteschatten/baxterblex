//
//  CharactersView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var gameStore: GameStore
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    #endif
    
    var body: some View {
        if let game = gameStore.selectedGame {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                iOSCompactCharactersView(game: game)
            }
            else {
                ColumnCharactersView(game: game)
            }
            #else
            ColumnCharactersView(game: game)
            #endif
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
