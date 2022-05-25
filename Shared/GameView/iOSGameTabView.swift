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
            
//                DashboardView()
//                    .tabItem {
//                        Label("Dashboard", systemImage: "square.grid.3x3.square")
//                    }
//                    .tag(GameViewTabs.dashboard)
            
            CharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
                .tag(GameViewTabs.characters)
            
            GearView()
                .tabItem {
                    Label("Gear", systemImage: "wrench.and.screwdriver.fill")
                }
                .tag(GameViewTabs.gear)
            
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
        }
    }
}

struct iOSGameTabView_Previews: PreviewProvider {
    static var previews: some View {
        iOSGameTabView()
    }
}
