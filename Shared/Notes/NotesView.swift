//
//  NotesView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        #if os(iOS)
        iOSNotesView()
        #else
        MacNotesView()
        #endif
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
