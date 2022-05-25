//
//  SingleGameViewContents.swift
//  Baxterblex
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct SingleGameViewContents: View {
    @EnvironmentObject private var gameStore: GameStore
    
    var body: some View {
        if let game = gameStore.selectedGame {
            ScrollView {
                VStack(spacing: 15) {
                    // TODO: add game picture
                    Image(systemName: "dice")
                        .font(.system(size: 100))
                        .padding(.bottom, 20)
                    
                    Text(game.name ?? DEFAULT_GAME_NAME)
                        .font(.title)
                        .bold()
                    
                    if game.archived {
                        Text("Archived")
                            .italic()
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    if let startDate = game.startDate {
                        HStack {
                            Text("Starts:")
                                .bold()
                            Text(formatDateLong(startDate))
                        }
                    }
                    
                    if let endDate = game.endDate {
                        HStack {
                            Text("Ends:")
                                .bold()
                            Text(formatDateLong(endDate))
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                #if os(macOS)
                .padding(15)
                #endif
            }
        }
        else {
            NoGameSelected()
        }
    }
}

struct SingleGameViewContents_Previews: PreviewProvider {
    static var previews: some View {
        SingleGameViewContents()
    }
}
