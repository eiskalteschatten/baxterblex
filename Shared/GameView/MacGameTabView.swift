//
//  MacGameTabView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacGameTabView: View {
    private enum Tabs: Int {
        case dashboard, character, gear, accounting, sessions
    }
    
    @AppStorage("selectedGameViewTab") private var selectedTab: Tabs = .dashboard
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .dashboard:
                DashboardView()
            case .character:
                CharacterView()
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
                    Text("Dashboard")
                        .tag(Tabs.dashboard)
                    
                    Text("Character")
                        .tag(Tabs.character)
                    
                    Text("Gear")
                        .tag(Tabs.gear)
                    
                    Text("Accounting")
                        .tag(Tabs.accounting)
                    
                    Text("Sessions")
                        .tag(Tabs.sessions)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct MacGameTabView_Previews: PreviewProvider {
    static var previews: some View {
        MacGameTabView()
    }
}
