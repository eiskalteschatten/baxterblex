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
    
    @State private var presentDeleteAlert = false
    @State private var characterToDelete: Character?
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
                        label: {
                            HStack {
                                Group {
                                    if let unwrappedImageStore = character.picture, let picture = unwrappedImageStore.image {
                                        let image = UIImage(data: picture)
                                        Image(uiImage: image!)
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
                            }
                        }
                    )
                    .contextMenu {
                        Button("Delete Character", role: .destructive, action: {
                            characterToDelete = character
                            presentDeleteAlert.toggle()
                        })
                    }
                }
                .onDelete(perform: deleteCharacters)
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
        .alert("Are you sure you want to delete this character?", isPresented: $presentDeleteAlert, actions: {
            Button("No", role: .cancel, action: {
                characterToDelete = nil
            })
            Button("Yes", role: .destructive, action: {
                if let character = characterToDelete {
                    EditCharacterModel.deleteCharacter(character)
                    characterToDelete = nil
                }
            })
        }, message: {
            Text("This cannot be undone")
        })
    }
    
    private func deleteCharacters(offsets: IndexSet) {
        withAnimation {
            let viewContext = PersistenceController.shared.container.viewContext
            offsets.map { characters[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // TODO
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
