//
//  GamesListView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct GamesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var gameStore: GameStore
    
    @SceneStorage("selectedGameURL") private var selectedGameURL: URL?
    @SceneStorage("selectedGameViewTab") private var selectedTab: GameViewTabs = .games
    
    @State private var gameToEdit: Game?
    
    #if os(iOS)
    @State private var presentDeleteAlert = false
    #endif

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.name, ascending: true)],
        animation: .default
    )
    private var games: FetchedResults<Game>
    
    var body: some View {
        VStack(spacing: 15) {
            #if os(iOS)
            Text("Baxterblex")
                .font(.system(.title))
                .bold()
            #endif
            
            List {
                Section("Games") {
                    ForEach(games.filter { !$0.archived }) { game in
                        GamesListItemView(game: game) {
                            selectedGameURL = game.objectID.uriRepresentation()
                            gameStore.selectedGame = game
                            selectedTab = .characters
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
                
                Section("Archived Games") {
                    ForEach(games.filter { $0.archived }) { game in
                        GamesListItemView(game: game) {
                            selectedGameURL = game.objectID.uriRepresentation()
                            gameStore.selectedGame = game
                            selectedTab = .characters
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
            
            Button(action: { gameStore.showEditGameSheet.toggle() }) {
                Label("Create a New Game", systemImage: "plus.circle")
            }
            .buttonStyle(BottomOfListButtonStyle())
            .padding(.bottom, 15)
        }
        .sheet(isPresented: $gameStore.showEditGameSheet) {
            EditGameSheet(game: gameToEdit)
        }
        .onChange(of: gameStore.showEditGameSheet) { show in
            if !show {
                gameToEdit = nil
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
        #endif
    }
    
    private func editGame(game: Game) {
        gameToEdit = game
        gameStore.showEditGameSheet.toggle()
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
