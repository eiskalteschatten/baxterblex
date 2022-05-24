//
//  MacEditGameForm.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacEditGameForm: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var editGameModel: EditGameModel
    var isEditing: Bool
    
    var body: some View {
        VStack {
            Text(isEditing ? "Edit Game" : "Create a New Game")
                .font(.system(.title))
            
            Form {
                TextField("Name", text: $editGameModel.name)
                    .padding(.bottom, 15)
                
                Section {
                    Toggle("Add Start Date", isOn: $editGameModel.addStartDate)

                    DatePicker(selection: $editGameModel.startDate, displayedComponents: .date) {
                        Text("Start Date:")
                    }
                    .disabled(!editGameModel.addStartDate)
                    .padding(.bottom)

                    Toggle("Add End Date", isOn: $editGameModel.addEndDate)

                    DatePicker(selection: $editGameModel.endDate, displayedComponents: .date) {
                        Text("End Date:")
                    }
                    .disabled(!editGameModel.addEndDate)
                    .padding(.bottom, 15)
                }
                
                Section {
                    Toggle("Archive Game", isOn: $editGameModel.archived)
                }
            }
            .frame(minWidth: 400)
            
            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Spacer()
                
                Button("Cancel") { dismiss() }
                    .keyboardShortcut(.cancelAction)
                
                Button("Save") {
                    editGameModel.save()
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
    }
}

struct MacEditGameForm_Previews: PreviewProvider {
    @StateObject static var editGameModel = EditGameModel()
    
    static var previews: some View {
        MacEditGameForm(editGameModel: editGameModel, isEditing: false)
    }
}
