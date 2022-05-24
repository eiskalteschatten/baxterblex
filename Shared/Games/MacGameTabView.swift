//
//  MacGameTabView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacGameTabView: View {
    @EnvironmentObject var gameStore: GameStore
    
    @SceneStorage("selectedGameViewTab") private var selectedTab: GameViewTabs = .games
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .games:
                GamesListView()
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
        .onAppear {
            if gameStore.selectedGame == nil {
                selectedTab = .games
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $selectedTab) {
                    Text("Games")
                        .tag(GameViewTabs.games)
                    
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
                case .games:
                    Button(action: { gameStore.showEditGameSheet.toggle() }) {
                        Label("Create a New Game", systemImage: "plus.circle")
                    }
                case .dashboard:
                    EmptyView()
                case .characters:
                    Button(action: { gameStore.createCharacter = true }) {
                        Label("Create a Character", systemImage: "person.badge.plus")
                    }
                case .gear:
                    Button(action: {  }) {
                        Label("Add Gear", systemImage: "plus.circle")
                    }
                case .accounting:
                    Button(action: {  }) {
                        Label("Add an Account", systemImage: "plus.circle")
                    }
                case .sessions:
                    Button(action: {  }) {
                        Label("Add a Session", systemImage: "rectangle.stack.badge.plus")
                    }
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
