//
//  EditGameSheet.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct EditGameSheet: View {
    var game: Game?
    
    @ObservedObject private var editGameModel: EditGameModel
    
    init(game: Game? = nil) {
        editGameModel = EditGameModel(game: game)
    }
    
    var body: some View {
        #if os(macOS)
        MacEditGameForm(editGameModel: editGameModel)
        #else
        iOSEditGameForm(editGameModel: editGameModel)
        #endif
    }
}

struct EditGameSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditGameSheet()
    }
}
