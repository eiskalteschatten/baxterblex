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
                Group {
                    if let unwrappedImageStore = game.picture, let picture = unwrappedImageStore.image {
                        Group {
                            #if os(macOS)
                            let image = NSImage(data: picture)
                            Image(nsImage: image!)
                                .resizable()
                                .scaledToFit()
                            #else
                            let image = UIImage(data: picture)
                            Image(uiImage: image!)
                                .resizable()
                                .scaledToFit()
                            #endif
                        }
                        .frame(maxHeight: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    else {
                        Image(systemName: DEFAULT_GAME_IMAGE_NAME)
                            .font(.system(size: 50))
                    }
                }
                .frame(height: 100)
                .padding(.bottom, 10)
                
                Text(game.name ?? DEFAULT_GAME_NAME)
                    .bold()
                    .padding(.bottom, 10)
                    #if os(macOS)
                    .font(.system(size: 15))
                    #endif
                
                Group {
                    if let startDate = game.startDate {
                        HStack {
                            Text("Starts:")
                                .font(.system(size: 12, weight: .semibold))
                            Text(formatDateLong(startDate))
                                .font(.system(size: 12))
                        }
                    }
                    else {
                        DatePlaceholderSpacer()
                    }
                    
                    if let endDate = game.endDate {
                        HStack {
                            Text("Ends:")
                                .font(.system(size: 12, weight: .semibold))
                            Text(formatDateLong(endDate))
                                .font(.system(size: 12))
                        }
                    }
                    else {
                        DatePlaceholderSpacer()
                    }
                }
                .opacity(0.7)
            }
            .frame(height: 210)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(RoundedFlatTileButtonStyle())
    }
}

fileprivate struct DatePlaceholderSpacer: View {
    var body: some View {
        Spacer()
            .frame(height: 15)
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
