//
//  GameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        #if os(iOS)
        iOSGameTabView()
        #else
        Text("to do")
        #endif
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
