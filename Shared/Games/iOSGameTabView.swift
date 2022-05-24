//
//  iOSGameTabView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSGameTabView: View {
    // TODO: change default to .dashboard as soon as the dashboard is implemented
    @SceneStorage("selectedGameViewTab") private var selectedTab: GameViewTabs = .characters
    
    var body: some View {
        TabView(selection: $selectedTab) {
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
