//
//  MacGameTabView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacGameTabView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var gameStore: GameStore
    
    @SceneStorage("selectedGameViewTab") private var selectedTab: GameViewTabs = .game
    @SceneStorage("selectedGameURL") private var selectedGameURL: URL?
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .game:
                SingleGameView()
            case .characters:
                CharactersView()
            case .accounting:
                AccountingView()
            case .sessions:
                SessionsView()
            case .notes:
                NotesView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    withAnimation {
                        gameStore.selectedGame = nil
                        selectedGameURL = nil
                    }
                }) {
                    Label("Open a Game", systemImage: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Picker("", selection: $selectedTab) {
                    Text("Game")
                        .tag(GameViewTabs.game)
                    
                    Text("Characters")
                        .tag(GameViewTabs.characters)
                    
                    Text("Accounting")
                        .tag(GameViewTabs.accounting)
                    
                    Text("Sessions")
                        .tag(GameViewTabs.sessions)
                    
                    Text("Notes")
                        .tag(GameViewTabs.notes)
                }
                .pickerStyle(.segmented)
            }
            
            ToolbarItemGroup {
                Spacer()
                
                switch selectedTab {
                case .game:
                    Button(action: { gameStore.showEditGameSheet = true }) {
                        Label("Edit Game", systemImage: "pencil")
                    }
                    .disabled(gameStore.selectedGame == nil)
                case .characters:
                    Button(action: {
                        gameStore.selectedCharacter = Character(context: viewContext)
                    }) {
                        Label("Create a Character", systemImage: "person.badge.plus")
                    }
                    .disabled(gameStore.selectedGame == nil)
                case .accounting:
                    Button(action: {  }) {
                        Label("Add an Account", systemImage: "plus.circle")
                    }
                    .disabled(gameStore.selectedGame == nil)
                case .sessions:
                    Button(action: {  }) {
                        Label("Add a Session", systemImage: "rectangle.stack.badge.plus")
                    }
                    .disabled(gameStore.selectedGame == nil)
                case .notes:
                    Button(action: {  }) {
                        Label("Add a Note", systemImage: "square.and.pencil")
                    }
                    .disabled(gameStore.selectedGame == nil)
                }
            }
        }
    }
}

struct MacGameTabView_Previews: PreviewProvider {
    static var previews: some View {
        MacGameTabView()
    }
}
