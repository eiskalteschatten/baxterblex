//
//  GearView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct GearView: View {
    var body: some View {
        Text("Gear")
            #if os(macOS)
            // Temp fix until this view is done
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
            #endif
    }
}

struct GearView_Previews: PreviewProvider {
    static var previews: some View {
        GearView()
    }
}
