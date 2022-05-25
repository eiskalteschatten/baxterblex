//
//  GamesListItemView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct GamesListItemView: View {
    var game: Game
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                // TODO: add game picture
                
                Text(game.name ?? DEFAULT_GAME_NAME)
                    #if os(macOS)
                    .bold()
                    #endif
                
                Spacer()
                
                VStack(alignment: .trailing) {
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
            .frame(height: 35)
        }
        .buttonStyle(RoundedFlatButtonStyle())
    }
}

struct GamesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let game = context.registeredObjects.first(where: { $0 is Game }) as! Game
        
        GamesListItemView(game: game, action: action)
    }
    
    static private func action() {}
}
