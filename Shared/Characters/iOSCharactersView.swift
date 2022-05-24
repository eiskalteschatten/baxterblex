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
    
    @FetchRequest private var characters: FetchedResults<Character>
    
    init(game: Game) {
        self._characters = FetchRequest<Character>(
            sortDescriptors: [SortDescriptor(\Character.name, order: .forward)],
            predicate: NSPredicate(format: "ANY game == %@", game),
            animation: .default
        )
        self.game = game
    }
    
    var body: some View {
        NavigationView {
            List(characters, id: \.self, selection: $gameStore.selectedCharacter) { character in
                Text(character.name ?? DEFAULT_CHARACTER_NAME)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if horizontalSizeClass == .compact {
                        Button (action: { gameStore.createCharacter = true }) {
                            Label("Create a Character", systemImage: "person.badge.plus")
                        }
                    }
                    else {
                        Button (action: { gameStore.createCharacter = true }) {
                            Label("Create a Character", systemImage: "person.badge.plus")
                        }
                    }
                }
            }
            
            Text("No character selected")
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
