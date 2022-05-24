//
//  ColumnCharactersView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct ColumnCharactersView: View {
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
        
        HStack(alignment: showEditCharacterView ? .top : .center) {
            List(characters, id: \.self, selection: $gameStore.selectedCharacter) { character in
                Text(character.name ?? DEFAULT_CHARACTER_NAME)
            }
            .listStyle(.plain)
            .frame(width: 300)
                
            Divider()
            
            Group {
                if showEditCharacterView {
                    EditCharacterView(character: gameStore.selectedCharacter)
                        .padding(15)
                }
                else {
                    Text("No character selected")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .onChange(of: gameStore.selectedCharacter) { _ in
            gameStore.createCharacter = false
        }
    }
}

struct ColumnCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        ColumnCharactersView(game: game)
    }
}
