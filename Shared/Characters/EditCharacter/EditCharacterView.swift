//
//  EditCharacterView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

enum EditCharacterViewTabs: Int {
    case overview, gear
}

struct EditCharacterView: View {
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
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 25)
            
            switch selectedTab {
            case .overview:
                EditCharacterOverview(editCharacterModel: editCharacterModel)
            case .gear:
                Text("Gear")
            }
            
            Spacer()
        }
        #if os(iOS)
        .padding(20)
        #endif
    }
}

struct EditCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        EditCharacterView()
    }
}
