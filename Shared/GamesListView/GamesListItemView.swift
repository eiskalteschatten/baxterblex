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
                Group {
                    if let unwrappedImageStore = game.picture, let picture = unwrappedImageStore.image {
                        #if os(macOS)
                        let image = NSImage(data: picture)
                        Image(nsImage: image!)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        #else
                        let image = UIImage(data: picture)
                        Image(uiImage: image!)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        #endif
                    }
                    else {
                        Image(systemName: DEFAULT_GAME_IMAGE_NAME)
                            .font(.system(size: 45))
                    }
                }
                .clipped()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(.trailing, 5)
                .padding(.vertical, 2)
                
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
