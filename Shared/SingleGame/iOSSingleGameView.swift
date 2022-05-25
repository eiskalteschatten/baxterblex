//
//  iOSSingleGameView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct iOSSingleGameView: View {
    @EnvironmentObject var gameStore: GameStore
    
    @SceneStorage("selectedGameURL") private var selectedGameURL: URL?
    
    var body: some View {
        NavigationView {
            SingleGameViewContents()
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {
                            withAnimation {
                                gameStore.selectedGame = nil
                                selectedGameURL = nil
                            }
                        }) {
                            Label("Open a Game", systemImage: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { gameStore.showEditGameSheet = true }) {
                            Label("Edit Game", systemImage: "pencil")
                        }
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct iOSSingleGameView_Previews: PreviewProvider {
    static var previews: some View {
        iOSSingleGameView()
    }
}
