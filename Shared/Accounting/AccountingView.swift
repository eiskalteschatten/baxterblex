//
//  AccountingView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct AccountingView: View {
    var body: some View {
        #if os(iOS)
        iOSAccountingView()
        #else
        MacAccountingView()
        #endif
    }
}

struct AccountingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountingView()
    }
}
