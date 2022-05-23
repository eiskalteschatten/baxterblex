//
//  GameView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "square.grid.3x3.square")
                }
            
            CharacterView()
                .tabItem {
                    Label("Character", systemImage: "person")
                }
            
            GearView()
                .tabItem {
                    Label("Gear", systemImage: "wrench.and.screwdriver.fill")
                }
            
            AccountingView()
                .tabItem {
                    Label("Accounting", systemImage: "dollarsign.square")
                }
            
            SessionsView()
                .tabItem {
                    Label("Sessions", systemImage: "doc.on.doc")
                }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
