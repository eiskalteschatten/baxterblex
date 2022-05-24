//
//  AccountingView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct AccountingView: View {
    var body: some View {
        Text("Accounting")
            #if os(macOS)
            // Temp fix until this view is done
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
            #endif
    }
}

struct AccountingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountingView()
    }
}
