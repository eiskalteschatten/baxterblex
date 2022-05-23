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
    
    @State private var showEditSheet = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.name, ascending: true)],
        animation: .default
    )
    private var games: FetchedResults<Game>

    var body: some View {
        NavigationView {
            List {
                Section("Games") {
                    ForEach(games.filter { !$0.archived }) { game in
                        NavigationLink {
                            // TODO: add game view
                            Text(game.name ?? DEFAULT_GAME_NAME)
                        } label: {
                            // TODO: add icon or color or something else
                            Text(game.name ?? DEFAULT_GAME_NAME)
                        }
                    }
                    .onDelete(perform: deleteGames)
                }
                
                Section("Archived Games") {
                    ForEach(games.filter { $0.archived }) { game in
                        NavigationLink {
                            // TODO: add game view
                            Text(game.name ?? DEFAULT_GAME_NAME)
                        } label: {
                            // TODO: add icon or color or something else
                            Text(game.name ?? DEFAULT_GAME_NAME)
                        }
                    }
                    .onDelete(perform: deleteGames)
                }
            }
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                #endif
                ToolbarItem {
                    Button(action: { showEditSheet.toggle() }) {
                        Label("Create a New Game", systemImage: "plus")
                    }
                }
            }
            #if os(iOS)
            .navigationBarTitle("Baxterblex")
            #endif
            
            // TODO: show monchrome icon
            Text("TODO: show monochrome icon")
        }
        .sheet(isPresented: $showEditSheet) {
            EditGameSheet()
        }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
