//
//  SingleGameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct SingleGameView: View {
    var body: some View {
        #if os(iOS)
        iOSSingleGameView()
        #else
        MacSingleGameView()
        #endif
    }
}

struct SingleGameView_Previews: PreviewProvider {
    static var previews: some View {
        SingleGameView()
    }
}
