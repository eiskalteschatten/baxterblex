//
//  AccountingView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct AccountingView: View {
    @EnvironmentObject var gameStore: GameStore
    
    var body: some View {
        if let game = gameStore.selectedGame {
            #if os(iOS)
            iOSAccountingView()
            #else
            MacAccountingView()
            #endif
        }
        else {
            Text("No game selected")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct AccountingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountingView()
    }
}
