//
//  MacGameTabView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacGameTabView: View {
    // TODO: change default to .dashboard as soon as the dashboard is implemented
    @SceneStorage("selectedGameViewTab") private var selectedTab: GameViewTabs = .characters
    
    var body: some View {
        VStack {
            switch selectedTab {
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $selectedTab) {
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
                .pickerStyle(SegmentedPickerStyle())
            }
            
            GameViewToolbar(selectedTab: selectedTab)
        }
    }
}

struct MacGameTabView_Previews: PreviewProvider {
    static var previews: some View {
        MacGameTabView()
    }
}
