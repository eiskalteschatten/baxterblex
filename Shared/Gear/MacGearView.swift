//
//  MacGearView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct MacGearView: View {
    var body: some View {
        Text("Gear")
            // Temp fix until this view is done
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct MacGearView_Previews: PreviewProvider {
    static var previews: some View {
        MacGearView()
    }
}
