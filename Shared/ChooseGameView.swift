//
//  ChooseGameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

fileprivate struct ChooseButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        let defaultColor: Color = colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color(red: 0.88, green: 0.88, blue: 0.88)
        let pressedColor: Color = colorScheme == .dark ? Color(red: 0.18, green: 0.18, blue: 0.18) : Color(red: 0.85, green: 0.85, blue: 0.85)
        
        configuration.label
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 15)
            .background(configuration.isPressed ? pressedColor : defaultColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .font(.system(size: 14))
    }
}

struct ChooseGameView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.updatedAt, ascending: true)],
        animation: .default)
    private var games: FetchedResults<Game>

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Button {
                // TODO: create new game
            } label : {
                Label("Create a New Game", systemImage: "plus")
            }
            .buttonStyle(ChooseButtonStyle())
            
            ScrollView {
                List {
                    ForEach(games) { game in
                        Button(game.name ?? "Untitled Game") {
                            // TODO: switch to the game view with an animation and persist the selected game
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .frame(width: 500)
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 20)
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
