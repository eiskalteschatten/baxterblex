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
    
    @State private var selectedTab: Tabs = .dashboard
    
    var body: some View {
        VStack {
            Text("test")
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
