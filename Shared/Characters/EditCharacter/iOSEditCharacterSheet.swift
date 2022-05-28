//
//  iOSEditCharacterSheet.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 28.05.22.
//

import SwiftUI

struct iOSEditCharacterSheet: View {
    @EnvironmentObject private var gameStore: GameStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            EditCharacterView()
                .navigationBarTitle(Text("Create a Character"), displayMode: .inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                        },
                        trailing: Button(action: {
                            if gameStore.editCharacterModel != nil {
                                gameStore.editCharacterModel!.save()
                            }
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
