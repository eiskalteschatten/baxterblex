//
//  iOSCharactersView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSCharactersView: View {
    @EnvironmentObject var gameStore: GameStore
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var game: Game
    
    @State private var showCreateCharacterScreen = false
    @FetchRequest private var characters: FetchedResults<Character>
    
    init(game: Game) {
        self._characters = FetchRequest<Character>(
            sortDescriptors: [SortDescriptor(\Character.name, order: .forward)],
            predicate: NSPredicate(format: "game == %@", game),
            animation: .default
        )
        self.game = game
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(characters) { character in
                    NavigationLink(
                        destination: EditCharacterView()
                                        .navigationTitle("Edit \(character.name ?? DEFAULT_CHARACTER_NAME)"),
                        tag: character,
                        selection: $gameStore.selectedCharacter,
                        label: { Text(character.name ?? DEFAULT_CHARACTER_NAME) }
                    )
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button (action: {
                        gameStore.selectedCharacter = nil
                        showCreateCharacterScreen = true
                    }) {
                        Label("Create a Character", systemImage: "person.badge.plus")
                    }
                }
            }
            .navigationTitle("Characters")
            
            VStack(spacing: 25) {
                Text("No character selected")
            }
        }
        .sheet(isPresented: $showCreateCharacterScreen) {
            iOSEditCharacterSheet()
        }
    }
}

struct iOSCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        iOSCharactersView(game: game)
    }
}
