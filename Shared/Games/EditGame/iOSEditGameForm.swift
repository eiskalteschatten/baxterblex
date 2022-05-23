//
//  iOSEditGameForm.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSEditGameForm: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var editGameModel = EditGameModel()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $editGameModel.name)
                
                Section {
                    Toggle("Add Start Date", isOn: $editGameModel.addStartDate.animation())

                    if editGameModel.addStartDate {
                        DatePicker(selection: $editGameModel.startDate, displayedComponents: .date) {
                            Text("Start Date:")
                        }
                        .transition(.scale)
                    }

                    Toggle("Add End Date", isOn: $editGameModel.addEndDate.animation())

                    if editGameModel.addEndDate {
                        DatePicker(selection: $editGameModel.endDate, displayedComponents: .date) {
                            Text("End Date:")
                        }
                        .transition(.scale)
                    }
                }
            }
            .navigationBarTitle(Text("Create a New Game"), displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    },
                    trailing: Button(action: {
                        editGameModel.save()
                        dismiss()
                    }) {
                        Text("Save").bold()
                    }
                )
        }
    }
}

struct iOSEditGameForm_Previews: PreviewProvider {
    static var previews: some View {
        iOSEditGameForm()
    }
}
