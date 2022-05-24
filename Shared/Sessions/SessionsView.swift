//
//  SessionsView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct SessionsView: View {
    @EnvironmentObject var gameStore: GameStore
    
    var body: some View {
        if let game = gameStore.selectedGame {
            #if os(iOS)
            iOSSessionsView()
            #else
            MacSessionsView()
            #endif
        }
        else {
            Text("No game selected")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView()
    }
}
