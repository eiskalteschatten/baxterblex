//
//  iOSEditCharacterSheet.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 28.05.22.
//

import SwiftUI

struct iOSEditCharacterSheet: View {
    @Environment(\.dismiss) var dismiss
    
    private var editCharacterModel = EditCharacterModel()
    
    var body: some View {
        NavigationView {
            EditCharacterView(editCharacterModel: editCharacterModel)
                .navigationBarTitle(Text("Create a Character"), displayMode: .inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                        },
                        trailing: Button(action: {
                            editCharacterModel.save()
                            dismiss()
                        }) {
                            Text("Save").bold()
                        }
                    )
        }
    }
}

struct iOSEditCharacterSheet_Previews: PreviewProvider {
    static var previews: some View {
        iOSEditCharacterSheet()
    }
}
