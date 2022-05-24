//
//  MacAccountingView.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct MacAccountingView: View {
    var body: some View {
        Text("Accounting")
            // Temp fix until this view is done
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct MacAccountingView_Previews: PreviewProvider {
    static var previews: some View {
        MacAccountingView()
    }
}
