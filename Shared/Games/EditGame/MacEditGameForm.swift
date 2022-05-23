//
//  MacEditGameForm.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct MacEditGameForm: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var editGameModel = EditGameModel()
    
    var body: some View {
        VStack {
            Text("Create a New Game")
                .font(.system(.title))
            
            Form {
                TextField("Name", text: $editGameModel.name)
                    .padding(.bottom, 15)
                
                Group {
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
    static var previews: some View {
        MacEditGameForm()
    }
}
