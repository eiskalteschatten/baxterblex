//
//  iOSGearView.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct iOSGearView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        NavigationView {
            Text("Gear")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if horizontalSizeClass == .compact {
                            Button(action: {  }) {
                                Label("Gear Menu", systemImage: "ellipsis.circle")
                            }
                        }
                        else {
                            Button(action: {  }) {
                                Label("Add Gear", systemImage: "plus.circle")
                            }
                        }
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct iOSGearView_Previews: PreviewProvider {
    static var previews: some View {
        iOSGearView()
    }
}
