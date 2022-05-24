//
//  MacSessionsView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct MacSessionsView: View {
    var body: some View {
        Text("Sessions")
            // Temp fix until this view is done
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct MacSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        MacSessionsView()
    }
}
