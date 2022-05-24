//
//  iOSGameTabView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSGameTabView: View {
    private enum Tabs: Int {
        case dashboard, characters, gear, accounting, sessions
    }
    
    // TODO: change default to .dashboard as soon as the dashboard is implemented
    @SceneStorage("selectedGameViewTab") private var selectedTab: Tabs = .characters
    
    var body: some View {
        TabView(selection: $selectedTab) {
//                DashboardView()
//                    .tabItem {
//                        Label("Dashboard", systemImage: "square.grid.3x3.square")
//                    }
//                    .tag(Tabs.dashboard)
            
            CharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
                .tag(Tabs.characters)
            
            GearView()
                .tabItem {
                    Label("Gear", systemImage: "wrench.and.screwdriver.fill")
                }
                .tag(Tabs.gear)
            
            AccountingView()
                .tabItem {
                    Label("Accounting", systemImage: "dollarsign.square")
                }
                .tag(Tabs.accounting)
            
            SessionsView()
                .tabItem {
                    Label("Sessions", systemImage: "doc.on.doc")
                }
                .tag(Tabs.sessions)
        }
        .toolbar(content: toolbarContent)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup {
            switch selectedTab {
            case .dashboard:
                EmptyView()
            case .characters:
                Button(action: {  }) {
                    Label("Create a Character", systemImage: "person.badge.plus")
                }
            case .gear:
                Button(action: {  }) {
                    Label("Gear Menu", systemImage: "ellipsis.circle")
                }
            case .accounting:
                Button(action: {  }) {
                    Label("Accounting Menu", systemImage: "ellipsis.circle")
                }
            case .sessions:
                Button(action: {  }) {
                    Label("Add a Session", systemImage: "doc.badge.plus")
                }
            }
        }
    }
}

struct iOSGameTabView_Previews: PreviewProvider {
    static var previews: some View {
        iOSGameTabView()
    }
}
