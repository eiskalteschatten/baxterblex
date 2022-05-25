//
//  iOSSessionsView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct iOSSessionsView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        NavigationView {
            Text("Sessions")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if horizontalSizeClass == .compact {
                            Button(action: {  }) {
                                Label("Add a Session", systemImage: "rectangle.stack.badge.plus")
                            }
                        }
                        else {
                            Button(action: {  }) {
                                Label("Add a Session", systemImage: "rectangle.stack.badge.plus")
                            }
                        }
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct iOSSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        iOSSessionsView()
    }
}
