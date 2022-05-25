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
                Image(systemName: "dice")
                    .font(.system(size: 25))
                    .padding(.trailing, 10)
                
                Text(game.name ?? DEFAULT_GAME_NAME)
                    .bold()
                    #if os(macOS)
                    .font(.system(size: 14))
                    #endif
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    if let startDate = game.startDate {
                        HStack {
                            Text("Starts:")
                                .font(.system(size: 12, weight: .semibold))
                            Text(formatDateLong(startDate))
                                .font(.system(size: 12))
                        }
                    }
                    
                    if let endDate = game.endDate {
                        HStack {
                            Text("Ends:")
                                .font(.system(size: 12, weight: .semibold))
                            Text(formatDateLong(endDate))
                                .font(.system(size: 12))
                        }
                    }
                }
                .opacity(0.7)
            }
            .frame(height: 40)
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
