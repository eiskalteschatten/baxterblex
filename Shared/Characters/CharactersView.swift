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
                .sheet(isPresented: $gameStore.showCreateCharacterSheet) {
                    NavigationView {
                        EditCharacterView()
                            .navigationBarTitle(Text("Create a Character"), displayMode: .inline)
                                .navigationBarItems(
                                    leading: Button(action: {
                                        gameStore.showCreateCharacterSheet = false
                                    }) {
                                        Text("Cancel")
                                    },
                                    trailing: Button(action: {
//                                        editGameModel.save()
                                        gameStore.showCreateCharacterSheet = false
                                    }) {
                                        Text("Save").bold()
                                    }
                                )
                    }
                }
            #else
            MacCharactersView(game: game)
                .sheet(isPresented: $gameStore.showCreateCharacterSheet) {
                    EditCharacterView()
                }
            #endif
        }
        else {
            NoGameSelected()
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
