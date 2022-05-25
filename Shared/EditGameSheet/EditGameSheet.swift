//
//  EditGameSheet.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct EditGameSheet: View {
    var game: Game?
    private var isEditing: Bool
    
    @ObservedObject private var editGameModel: EditGameModel
    
    init(game: Game? = nil) {
        editGameModel = EditGameModel(game: game)
        isEditing = game != nil
    }
    
    var body: some View {
        #if os(macOS)
        MacEditGameForm(editGameModel: editGameModel, isEditing: isEditing)
        #else
        iOSEditGameForm(editGameModel: editGameModel, isEditing: isEditing)
        #endif
    }
}

struct EditGameSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditGameSheet()
    }
}
