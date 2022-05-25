//
//  ContentView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedGameURL") private var selectedGameURL: URL?
    
    var body: some View {
        if selectedGameURL == nil {
            GamesListView()
                .transition(AnyTransition.asymmetric(
                    insertion: .move(edge: .leading),
                    removal: .move(edge: .trailing)
                ))
        }
        else {
            GameView()
                .transition(AnyTransition.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
