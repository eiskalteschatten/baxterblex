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
    
    @State private var name: String = ""
    @State private var addStartDate: Bool = false
    @State private var startDate: Date = Date()
    @State private var addEndDate: Bool = false
    @State private var endDate: Date = Date()
    
    var body: some View {
        VStack {
            Text("Create a New Game")
                .font(.system(.title))
            
            Form {
                TextField("Name", text: $name)
                    #if os(macOS)
                    .padding(.bottom, 15)
                    #endif
                
                #if os(macOS)
                Group {
                    Toggle("Add Start Date", isOn: $addStartDate)

                    DatePicker(selection: $startDate, displayedComponents: .date) {
                        Text("Start Date:")
                    }
                    .disabled(!addStartDate)
                    .padding(.bottom)

                    Toggle("Add End Date", isOn: $addEndDate)

                    DatePicker(selection: $endDate, displayedComponents: .date) {
                        Text("End Date:")
                    }
                    .disabled(!addEndDate)
                }
//                #else
//                // TODO
                #endif
            }
            #if os(macOS)
            .frame(minWidth: 400)
            #endif
            
            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Spacer()
                
                Button("Cancel") { showEditSheet = false }
                    .keyboardShortcut(.cancelAction)
                
                Button("Save") {
                    addGame()
                    showEditSheet = false
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        #if os(macOS)
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        #else
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { showEditSheet = false }
            }
            ToolbarItem {
                Button("Save") {
                    addGame()
                    showEditSheet = false
                }
            }
        }
        #endif
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
