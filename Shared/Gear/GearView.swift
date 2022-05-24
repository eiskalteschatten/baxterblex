//
//  GearView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct GearView: View {
    @EnvironmentObject var gameStore: GameStore
    
    var body: some View {
        if let game = gameStore.selectedGame {
            #if os(iOS)
            iOSGearView()
            #else
            MacGearView()
            #endif
        }
        else {
            Text("No game selected.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct GearView_Previews: PreviewProvider {
    static var previews: some View {
        GearView()
    }
}
