//
//  iOSCompactCharactersView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSCompactCharactersView: View {
    @EnvironmentObject var gameStore: GameStore
    
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
        let showEditCharacterView = gameStore.createCharacter || gameStore.selectedCharacter != nil
        
        if showEditCharacterView {
            EditCharacterView(character: gameStore.selectedCharacter)
                .transition(.slide)
        }
        else {
            // TODO: simulate a stacked navigation view
            List(characters, id: \.self, selection: $gameStore.selectedCharacter) { character in
                Text(character.name ?? DEFAULT_CHARACTER_NAME)
            }
            .listStyle(.plain)
            .transition(.slide)
        }
    }
}

struct iOSCompactCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        iOSCompactCharactersView(game: game)
    }
}
