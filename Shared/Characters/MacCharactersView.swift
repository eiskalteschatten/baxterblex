//
//  MacCharactersView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacCharactersView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var gameStore: GameStore
    
    var game: Game
    
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
        HSplitView {
            List(characters, id: \.self, selection: $gameStore.selectedCharacter) { character in
                HStack {
                    Group {
                        if let unwrappedImageStore = character.picture, let picture = unwrappedImageStore.image {
                            let image = NSImage(data: picture)
                            Image(nsImage: image!)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        else {
                            Image(systemName: DEFAULT_CHARACTER_IMAGE_NAME)
                                .font(.system(size: 35))
                        }
                    }
                    .clipped()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .padding(.trailing, 5)
                    .padding(.vertical, 2)
                    
                    Text(character.name ?? DEFAULT_CHARACTER_NAME)
                        .font(.system(size: 13))
                }
                .contextMenu {
                    Button("Delete Character", role: .destructive, action: {
//                            confirmDelete(game: game)
                    })
                }
            }
            .frame(minWidth: 250, idealWidth: 300, maxHeight: .infinity)
            .listStyle(.sidebar)

            // Use a VStack so that the HSplitView doesn't move when switching between the two views within
            VStack {
                if gameStore.selectedCharacter != nil {
                    EditCharacterView()
                        .padding(15)
                }
                else {
                    VStack(spacing: 25) {
                        Text("No character selected")
                        
                        Button {
                            gameStore.selectedCharacter = Character(context: viewContext)
                        } label : {
                            Label("Create a Character", systemImage: "person.badge.plus")
                        }
                        .buttonStyle(RoundedFlatButtonStyle())
                    }
                }
            }
            .frame(minWidth: 300, maxWidth: .infinity, maxHeight: .infinity)
            .layoutPriority(1)
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
