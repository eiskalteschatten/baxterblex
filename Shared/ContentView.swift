//
//  ContentView.swift
//  Shared
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("selectedGame") private var selectedGame: String?
    
    @State private var showEditSheet = false
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
        NavigationView {
            ZStack {
                VStack {
                    List {
                        Section("Games") {
                            ForEach(games.filter { !$0.archived }) { game in
                                NavigationLink(
                                    // TODO: keep track of selected game
                                    destination: GameView(),
                                    tag: game.objectID.uriRepresentation().path,
                                    selection: $selectedGame,
                                    // TODO: add icon or color or something else
                                    label: { Text(game.name ?? DEFAULT_GAME_NAME) }
                                )
                                .contextMenu {
                                    Button("Edit \"\(game.name ?? DEFAULT_GAME_NAME)\"", action: {
                                        editGame(game: game)
                                    })
                                    Divider()
                                    Button("Delete \"\(game.name ?? DEFAULT_GAME_NAME)\"", role: .destructive, action: {
                                        confirmDelete(game: game)
                                    })
                                }
                            }
                            .onDelete(perform: deleteGames)
                        }
                        
                        Section("Archived Games") {
                            ForEach(games.filter { $0.archived }) { game in
                                NavigationLink(
                                    // TODO: keep track of selected game
                                    destination: GameView(),
                                    tag: game.objectID.uriRepresentation().path,
                                    selection: $selectedGame,
                                    // TODO: add icon or color or something else
                                    label: { Text(game.name ?? DEFAULT_GAME_NAME) }
                                )
                                .contextMenu {
                                    Button("Edit \"\(game.name ?? DEFAULT_GAME_NAME)\"", action: {
                                        editGame(game: game)
                                    })
                                    Divider()
                                    Button("Delete \"\(game.name ?? DEFAULT_GAME_NAME)\"", role: .destructive, action: {
                                        confirmDelete(game: game)
                                    })
                                }
                            }
                            .onDelete(perform: deleteGames)
                        }
                    }
                }
                .padding(.bottom, 35)
                
                #if os(macOS)
                VStack(alignment: .center) {
                    Spacer()

                    Button {
                        showEditSheet.toggle()
                    } label: {
                        Label("Create a New Game", systemImage: "plus")
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 10)
                }
                #endif
            }
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showEditSheet.toggle() }) {
                        Label("Create a New Game", systemImage: "plus")
                    }
                }
                #else
                ToolbarItem {
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.leading")
                    })
                }
                #endif
            }
            .onChange(of: showEditSheet) { show in
                if !show {
                    gameToEdit = nil
                }
            }
            #if os(iOS)
            .navigationBarTitle("Baxterblex")
            .alert("Are you sure you want to delete this game?", isPresented: $presentDeleteAlert, actions: {
                Button("No", role: .cancel, action: {
                    gameToEdit = nil
                })
                Button("Yes", role: .destructive, action: deleteGame)
            }, message: {
                Text("Everything within the game will be deleted.")
            })
            #else
            .frame(minWidth: 175)
            #endif
            
            // TODO: show monchrome icon
            Text("TODO: show monochrome icon")
        }
        .sheet(isPresented: $showEditSheet) {
            EditGameSheet(game: gameToEdit)
        }
    }
    
    private func editGame(game: Game) {
        gameToEdit = game
        showEditSheet.toggle()
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
                if unwrapped.objectID.uriRepresentation().path == selectedGame {
                    selectedGame = nil
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
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    #endif
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
