//
//  iOSEditGameForm.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct iOSEditGameForm: View {
    @Binding var showEditSheet: Bool
    
    @StateObject private var editGameModel = EditGameModel()
    
    var body: some View {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { showEditSheet = false }
            }
            ToolbarItem {
                Button("Save") {
                    editGameModel.save()
                    showEditSheet = false
                }
            }
        }
    }
}

struct iOSEditGameForm_Previews: PreviewProvider {
    @State static var showEditSheet = false
    
    static var previews: some View {
        iOSEditGameForm(showEditSheet: $showEditSheet)
    }
}
