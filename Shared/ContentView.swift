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
                .transition(.opacity)
        }
        else {
            GameView()
                .transition(.opacity)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
