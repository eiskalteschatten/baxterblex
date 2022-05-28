//
//  iOSGameTabView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSGameTabView: View {
    @EnvironmentObject private var gameStore: GameStore
    
    @SceneStorage("selectedGameViewTab") private var selectedTab: GameViewTabs = .game
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SingleGameView()
                .tabItem {
                    Label("Game", systemImage: "dice.fill")
                }
                .tag(GameViewTabs.game)
            
            CharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
                .tag(GameViewTabs.characters)
            
            AccountingView()
                .tabItem {
                    Label("Accounting", systemImage: "dollarsign.square")
                }
                .tag(GameViewTabs.accounting)
            
            SessionsView()
                .tabItem {
                    Label("Sessions", systemImage: "rectangle.stack.fill")
                }
                .tag(GameViewTabs.sessions)
            
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }
                .tag(GameViewTabs.notes)
        }
    }
}

struct iOSGameTabView_Previews: PreviewProvider {
    static var previews: some View {
        iOSGameTabView()
    }
}
