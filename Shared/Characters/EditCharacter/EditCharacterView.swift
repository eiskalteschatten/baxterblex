//
//  EditCharacterView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

enum EditCharacterViewTabs: Int {
    case overview, gear, stats, health
}

struct EditCharacterView: View {
    @EnvironmentObject private var gameStore: GameStore
    
    var character: Character?
    
    @ObservedObject private var editCharacterModel: EditCharacterModel
    @SceneStorage("selectedEditCharacterTab") private var selectedTab: EditCharacterViewTabs = .overview
    
    init(character: Character? = nil) {
        self.editCharacterModel = EditCharacterModel(character: character)
        self.character = character
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Overview")
                    .tag(EditCharacterViewTabs.overview)
                
                Text("Gear")
                    .tag(EditCharacterViewTabs.gear)
                
                Text("Stats")
                    .tag(EditCharacterViewTabs.stats)
                
                Text("Health")
                    .tag(EditCharacterViewTabs.health)
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 20)
            
            switch selectedTab {
            case .overview:
                EditCharacterOverview(editCharacterModel: editCharacterModel)
            case .stats:
                Text("Stats")
            case .gear:
                Text("Gear")
            case .health:
                Text("Health")
            }
            
            Spacer()
        }
        .onAppear {
            if let game = gameStore.selectedGame {
                editCharacterModel.setGame(game)
            }
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
