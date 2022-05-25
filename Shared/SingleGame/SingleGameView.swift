//
//  SingleGameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct SingleGameView: View {
    @EnvironmentObject private var gameStore: GameStore
    
    var body: some View {
        if let game = gameStore.selectedGame {
            VStack(spacing: 15) {
                // TODO: add game picture
                
                Text(game.name ?? DEFAULT_GAME_NAME)
                    .font(.title)
                    .bold()
                
                if let startDate = game.startDate {
                    Text("Starts: \(formatDateLong(startDate))")
                }
                
                if let endDate = game.endDate {
                    Text("Ends: \(formatDateLong(endDate))")
                }
                
                Spacer()
            }
            .padding(15)
        }
        else {
            ResizableText("No game selected")
        }
    }
}

struct SingleGameView_Previews: PreviewProvider {
    static var previews: some View {
        SingleGameView()
    }
}
