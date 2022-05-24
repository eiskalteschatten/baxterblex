//
//  ButtomOfListButton.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct ButtomOfListButton<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            content
                .buttonStyle(BottomOfListButtonStyle())
        }
        .padding(.bottom, 8)
    }
}

struct ButtomOfListButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtomOfListButton {
            Button("Test") {}
        }
    }
}
