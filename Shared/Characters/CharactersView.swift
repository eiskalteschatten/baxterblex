//
//  CharactersView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var gameStore: GameStore
    
    var body: some View {
        if let game = gameStore.selectedGame {
            #if os(iOS)
            iOSCharactersView(game: game)
            #else
            MacCharactersView(game: game)
            #endif
        }
        else {
            ResizableText("No game selected")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
