//
//  MacCharactersView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacCharactersView: View {
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
        HStack {
            List(characters, id: \.self, selection: $gameStore.selectedCharacter) { character in
                Text(character.name ?? DEFAULT_CHARACTER_NAME)
            }
            .listStyle(.plain)
            .frame(width: 300)
                
            Divider()
            
            Group {
                if gameStore.selectedCharacter != nil {
                    EditCharacterView(character: gameStore.selectedCharacter)
                        #if os(macOS)
                        .padding(15)
                        #endif
                }
                else {
                    VStack(spacing: 15) {
                        Text("No character selected")
                        
                        Button {
                            gameStore.showCreateCharacterSheet = true
                        } label : {
                            Label("Create a Character", systemImage: "plus.circle")
                                .buttonStyle(RoundedFlatButtonStyle())
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .onChange(of: gameStore.selectedCharacter) { _ in
            gameStore.showCreateCharacterSheet = false
        }
    }
}

struct MacCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        MacCharactersView(game: game)
    }
}
