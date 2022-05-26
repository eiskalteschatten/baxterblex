//
//  MacNotesView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct MacNotesView: View {
    var body: some View {
        Text("Notes")
            // Temp fix until this view is done
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct MacNotesView_Previews: PreviewProvider {
    static var previews: some View {
        MacNotesView()
    }
}
