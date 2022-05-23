//
//  EditGameSheet.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct EditGameSheet: View {
    var body: some View {
        #if os(macOS)
        MacEditGameForm()
        #else
        iOSEditGameForm()
        #endif
    }
}

struct EditGameSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditGameSheet()
    }
}
