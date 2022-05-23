//
//  ChooseGameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct ChooseGameView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.updatedAt, ascending: true)],
        animation: .default)
    private var games: FetchedResults<Game>

    var body: some View {
        List {
            ForEach(games) { game in
                Button(game.name ?? "Untitled Game") {
                    // TODO: switch to the game view with an animation and persist the selected game
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newGame = Game(context: viewContext)
            newGame.createdAt = Date()
            newGame.updatedAt = Date()
            // TODO: add the rest of the fields

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

    private func deleteItems(offsets: IndexSet) {
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

struct ChooseGameView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseGameView()
    }
}
