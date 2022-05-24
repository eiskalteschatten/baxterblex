//
//  ColumnCharactersView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct ColumnCharactersView: View {
    var game: Game
    
    @State private var selectedCharacter: Character?
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
            ZStack {
                List(characters, id: \.self, selection: $selectedCharacter) { character in
                    Text(character.name ?? DEFAULT_CHARACTER_NAME)
                }
                .listStyle(.plain)
                
                #if os(macOS)
                ButtomOfListButton {
                    Button {
                        // TODO
                    } label : {
                        Label("Create a Character", systemImage: "person.badge.plus")
                    }
                }
                #endif
            }
            .frame(width: 300)
                
            Divider()
            
            Group {
                if let character = selectedCharacter {
                    Text("TODO: show edit character screen")
                }
                else {
                    Text("No character selected")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ColumnCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        ColumnCharactersView(game: game)
    }
}
