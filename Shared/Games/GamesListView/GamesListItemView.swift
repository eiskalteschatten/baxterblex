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
                Text(game.name ?? DEFAULT_GAME_NAME)
                    .bold()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    if let startDate = game.startDate {
                        Text("Starts on \(formatDateLong(startDate))")
                            .font(.caption)
                            .padding(.trailing, 20)
                    }
                    
                    if let endDate = game.endDate {
                        Text("Ends on \(formatDateLong(endDate))")
                            .font(.caption)
                    }
                }
                .opacity(0.7)
            }
            .frame(height: 35)
        }
        #if os(macOS)
        .buttonStyle(RoundedFlatButtonStyle())
        #else
        .buttonStyle(.plain)
        #endif
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
