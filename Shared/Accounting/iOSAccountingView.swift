//
//  iOSAccountingView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct iOSAccountingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        NavigationView {
            Text("Accounting")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if horizontalSizeClass == .compact {
                            Button(action: {  }) {
                                Label("Accounting Menu", systemImage: "ellipsis.circle")
                            }
                        }
                        else {
                            Button(action: {  }) {
                                Label("Add an Account", systemImage: "plus.circle")
                            }
                        }
                    }
                }
                .navigationTitle("Accounting")
        }
        .navigationViewStyle(.stack)
    }
}

struct iOSAccountingView_Previews: PreviewProvider {
    static var previews: some View {
        iOSAccountingView()
    }
}
