//
//  EditGameSheet.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct EditGameSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showEditSheet: Bool
    
    var body: some View {
        VStack {
            Text("Create a New Game")
                .font(.system(.title))
            
            Form {
//                TextField("Name", text: $editNamedElementViewModel.name)
                
//                #if os(macOS)
//                Group {
//                    Toggle("Add Start Date", isOn: $bookModel.addDateStarted)
//                    
//                    DatePicker(selection: $bookModel.dateStarted, displayedComponents: .date) {
//                        Text("Start Date:")
//                    }
//                    .disabled(!bookModel.addDateStarted)
//                    .padding(.bottom)
//                    
//                    Toggle("Add End Date", isOn: $bookModel.addDateFinished)
//                
//                    DatePicker(selection: $bookModel.dateFinished, displayedComponents: .date) {
//                        Text("End Date:")
//                    }
//                    .disabled(!bookModel.addDateFinished)
//                }
//                #else
//                // TODO
//                #endif
            }
        }
    }
    
    private func addGame() {
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
}

struct EditGameSheet_Previews: PreviewProvider {
    @State static var showEditSheet = false
    
    static var previews: some View {
        EditGameSheet(showEditSheet: $showEditSheet)
    }
}
