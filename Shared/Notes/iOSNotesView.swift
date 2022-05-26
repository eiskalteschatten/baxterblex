//
//  iOSNotesView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct iOSNotesView: View {
    var body: some View {
        NavigationView {
            Text("Notes")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {  }) {
                            Label("Add a Note", systemImage: "square.and.pencil")
                        }
                    }
                }
                .navigationTitle("Notes")
        }
    }
}

struct iOSNotesView_Previews: PreviewProvider {
    static var previews: some View {
        iOSNotesView()
    }
}
