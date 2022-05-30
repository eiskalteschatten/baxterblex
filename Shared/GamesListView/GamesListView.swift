//
//  GamesListView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct GamesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @SceneStorage("selectedGameURL") private var selectedGameURL: URL?
    
    @State private var showEditGameSheet = false
    @State private var gameToEdit: Game?
    
    #if os(iOS)
    @State private var presentDeleteAlert = false
    #endif

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.name, ascending: true)],
        animation: .default
    )
    private var games: FetchedResults<Game>
    
    private var gameGrid = [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]
    
    var body: some View {
        VStack(spacing: 15) {
            #if os(iOS)
            Text("Baxterblex")
                .font(.system(.title))
                .bold()
                .padding(.top, 20)
            #endif
            
            ScrollView {
                VStack {
                    #if os(iOS)
                    Button(action: { showEditGameSheet.toggle() }) {
                        Label("Create a New Game", systemImage: "plus.circle")
                    }
                    .padding(.bottom, 30)
                    #endif
                    
                    let notArchivedGames = games.filter { !$0.archived }
                    
                    if notArchivedGames.count > 0 {
                        LazyVGrid(columns: gameGrid, alignment: .center, spacing: 15) {
                            ForEach(notArchivedGames) { game in
                                GameListItemTileView(game: game) {
                                    withAnimation {
                                        selectedGameURL = game.objectID.uriRepresentation()
                                    }
                                }
                                .contextMenu {
                                    Button("Edit Game", action: {
                                        editGame(game: game)
                                    })
                                    Divider()
                                    Button("Delete Game", role: .destructive, action: {
                                        confirmDelete(game: game)
                                    })
                                }
                            }
                        }
                    }
                    else {
                        #if os(macOS)
                        Button(action: { showEditGameSheet.toggle() }) {
                            Label("Create a New Game", systemImage: "plus.circle")
                                .font(.system(size: 16))
                        }
                        .buttonStyle(RoundedFlatButtonStyle())
                        .padding(.bottom, 30)
                        #endif
                    }
                    
                    let archivedGames = games.filter { $0.archived }

                    if archivedGames.count > 0 {
                        VStack {
                            Text("Archived Games")
                                .font(.system(size: 18, weight: .bold))
                                .padding(.top, 50)
                                .padding(.bottom, 15)
                            
                            ForEach(archivedGames) { game in
                                GamesListItemView(game: game) {
                                    withAnimation {
                                        selectedGameURL = game.objectID.uriRepresentation()
                                    }
                                }
                                .contextMenu {
                                    Button("Edit Game", action: {
                                        editGame(game: game)
                                    })
                                    Divider()
                                    Button("Delete Game", role: .destructive, action: {
                                        confirmDelete(game: game)
                                    })
                                }
                            }
                            .onDelete(perform: deleteGames)
                        }
                    }
                }
                .padding(25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .sheet(isPresented: $showEditGameSheet) {
            EditGameSheet(game: gameToEdit)
        }
        .onChange(of: showEditGameSheet) { show in
            if !show {
                gameToEdit = nil
            }
        }
        .toolbar {
            Button(action: { showEditGameSheet.toggle() }) {
                Label("Create a New Game", systemImage: "plus.circle")
            }
        }
        #if os(iOS)
        .alert("Are you sure you want to delete this game?", isPresented: $presentDeleteAlert, actions: {
            Button("No", role: .cancel, action: {
                gameToEdit = nil
            })
            Button("Yes", role: .destructive, action: deleteGame)
        }, message: {
            Text("Everything within the game will be deleted.")
        })
        #else
        .frame(minWidth: 600)
        #endif
    }
    
    private func editGame(game: Game) {
        gameToEdit = game
        showEditGameSheet.toggle()
    }
    
    private func confirmDelete(game: Game) {
        gameToEdit = game
        
        #if os(macOS)
        promptToDeleteGame()
        #else
        presentDeleteAlert.toggle()
        #endif
    }
    
    private func deleteGames(offsets: IndexSet) {
        withAnimation {
            offsets.map { games[$0] }.forEach(viewContext.delete)

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
    
    private func deleteGame() {
        if let unwrapped = gameToEdit {
            withAnimation {
                if unwrapped.objectID.uriRepresentation() == selectedGameURL {
                    selectedGameURL = nil
                }
                
                viewContext.delete(unwrapped)
                gameToEdit = nil
                
                do {
                    try viewContext.save()
                } catch {
                    // TODO
    //                handleCoreDataError(error as NSError)
                }
            }
        }
    }
    
    #if os(macOS)
    private func promptToDeleteGame() {
        let alert = NSAlert()
        alert.messageText = "Are you sure you want to delete this game?"
        alert.informativeText = "Everything within the game will be deleted."
        alert.addButton(withTitle: "No")
        alert.addButton(withTitle: "Yes")
        alert.alertStyle = .warning
        
        let delete = alert.runModal() == NSApplication.ModalResponse.alertSecondButtonReturn
        
        if delete {
            deleteGame()
        }
    }
    #endif
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GamesListView()
    }
}
