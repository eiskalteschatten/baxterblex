//
//  CharacterAttributeEditorSheet.swift
//  Baxterblex
//
//  Created by Alex Seifert on 31.05.22.
//

import SwiftUI

struct CharacterAttributeEditorSheet: View {
    var body: some View {
        #if os(macOS)
        MacCharacterAttributeEditor()
        #else
        // TODO
        #endif
    }
}

struct CharacterAttributeEditorSheet_Previews: PreviewProvider {
    static var previews: some View {
        CharacterAttributeEditorSheet()
    }
}
