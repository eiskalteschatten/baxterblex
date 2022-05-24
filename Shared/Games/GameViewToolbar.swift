//
//  GameViewToolbar.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct GameViewToolbar: ToolbarContent {
    var selectedTab: GameViewTabs
    
    #if os(iOS)
    var horizontalSizeClass: UserInterfaceSizeClass?
    #endif
    
    var body: some ToolbarContent {
        ToolbarItemGroup {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                GameViewToolbarCompact(selectedTab: selectedTab)
            }
            else {
                GameViewToolbarLarge(selectedTab: selectedTab)
            }
            #else
            GameViewToolbarLarge(selectedTab: selectedTab)
            #endif
        }
    }
}

fileprivate struct GameViewToolbarCompact: View {
    @EnvironmentObject var gameStore: GameStore
    
    var selectedTab: GameViewTabs

    var body: some View {
        switch selectedTab {
        case .dashboard:
            EmptyView()
        case .characters:
            Button(action: { gameStore.createCharacter = true }) {
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
                Label("Add a Session", systemImage: "rectangle.stack.badge.plus")
            }
        }
    }
}

fileprivate struct GameViewToolbarLarge: View {
    @EnvironmentObject var gameStore: GameStore
    
    var selectedTab: GameViewTabs

    var body: some View {
        #if os(macOS)
        Spacer()
        #endif
        
        switch selectedTab {
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
