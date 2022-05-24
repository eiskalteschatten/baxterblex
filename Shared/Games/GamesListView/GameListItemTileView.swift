//
//  GameListItemTileView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct GameListItemTileView: View {
    var game: Game
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(game.name ?? DEFAULT_GAME_NAME)
                    .bold()
                    .padding(.bottom, 5)
                
                Group {
                    if let startDate = game.startDate {
                        Text("Starts: \(formatDateLong(startDate))")
                            .font(.caption)
                    }
                    
                    if let endDate = game.endDate {
                        Text("Ends: \(formatDateLong(endDate))")
                            .font(.caption)
                    }
                }
                .opacity(0.7)
            }
            .frame(height: 80)
        }
        .buttonStyle(RoundedFlatButtonStyle())
    }
}

struct GameListItemTileView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        GameListItemTileView(game: game, action: action)
    }
    
    static private func action() {}
}
