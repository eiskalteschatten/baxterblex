//
//  iOSEditGameForm.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSEditGameForm: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var editGameModel: EditGameModel
    var isEditing: Bool
    
    var body: some View {
        NavigationView {
            Form {
                iOSImagePickerMenu(imageStore: $editGameModel.picture)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                
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
                
                Section {
                    Toggle("Archive Game", isOn: $editGameModel.archived)
                }
            }
            .navigationBarTitle(Text(isEditing ? "Edit Game" : "Create a New Game"), displayMode: .inline)
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
    @StateObject static var editGameModel = EditGameModel()
    
    static var previews: some View {
        iOSEditGameForm(editGameModel: editGameModel, isEditing: false)
    }
}
