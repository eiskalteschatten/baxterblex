//
//  MacGameTabView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacGameTabView: View {
    @EnvironmentObject var gameStore: GameStore
    
    @SceneStorage("selectedGameViewTab") private var selectedTab: GameViewTabs = .game
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .game:
                SingleGameView()
            case .dashboard:
                DashboardView()
            case .characters:
                CharactersView()
            case .gear:
                GearView()
            case .accounting:
                AccountingView()
            case .sessions:
                SessionsView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $selectedTab) {
                    Text("Game")
                        .tag(GameViewTabs.game)
                    
//                    Text("Dashboard")
//                        .tag(GameViewTabs.dashboard)
//                    
                    Text("Characters")
                        .tag(GameViewTabs.characters)
                    
                    Text("Gear")
                        .tag(GameViewTabs.gear)
                    
                    Text("Accounting")
                        .tag(GameViewTabs.accounting)
                    
                    Text("Sessions")
                        .tag(GameViewTabs.sessions)
                }
                .pickerStyle(.segmented)
            }
            
            ToolbarItemGroup {
                Spacer()
                
                switch selectedTab {
                case .game:
                    Button(action: {  }) {
                        Label("Create a New Game", systemImage: "plus.circle")
                    }
                    Button(action: {  }) {
                        Label("Edit Game", systemImage: "pencil.circle")
                    }
                case .dashboard:
                    EmptyView()
                case .characters:
                    Button(action: { gameStore.createCharacter = true }) {
                        Label("Create a Character", systemImage: "person.badge.plus")
                    }
                    .disabled(gameStore.selectedGame == nil)
                case .gear:
                    Button(action: {  }) {
                        Label("Add Gear", systemImage: "plus.circle")
                    }
                    .disabled(gameStore.selectedGame == nil)
                case .accounting:
                    Button(action: {  }) {
                        Label("Add an Account", systemImage: "plus.circle")
                    }
                    .disabled(gameStore.selectedGame == nil)
                case .sessions:
                    Button(action: {  }) {
                        Label("Add a Session", systemImage: "rectangle.stack.badge.plus")
                    }
                    .disabled(gameStore.selectedGame == nil)
                }
            }
        }
    }
}

struct MacGameTabView_Previews: PreviewProvider {
    static var previews: some View {
        MacGameTabView()
    }
}
