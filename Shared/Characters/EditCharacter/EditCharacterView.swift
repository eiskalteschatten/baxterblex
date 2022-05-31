//
//  EditCharacterView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

enum EditCharacterViewTabs: Int {
    case overview, gear, attributes, health
}

struct EditCharacterView: View {
    @EnvironmentObject private var gameStore: GameStore
    
    @SceneStorage("selectedEditCharacterTab") private var selectedTab: EditCharacterViewTabs = .overview
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Overview")
                    .tag(EditCharacterViewTabs.overview)
                
                Text("Gear")
                    .tag(EditCharacterViewTabs.gear)
                
                Text("Attributes")
                    .tag(EditCharacterViewTabs.attributes)
                
                Text("Health")
                    .tag(EditCharacterViewTabs.health)
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 20)
            
            switch selectedTab {
            case .overview:
                EditCharacterOverview(editCharacterModel: gameStore.editCharacterModel!)
            case .attributes:
                EditCharacterAttributes(editCharacterModel: gameStore.editCharacterModel!)
            case .gear:
                Text("Gear")
            case .health:
                Text("Health")
            }
            
            Spacer()
        }
        #if os(iOS)
        .padding(.horizontal, 20)
        #endif
    }
}

struct EditCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        EditCharacterView()
    }
}
