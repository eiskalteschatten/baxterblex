//
//  SessionsView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct SessionsView: View {
    var body: some View {
        #if os(iOS)
        iOSSessionsView()
        #else
        MacSessionsView()
        #endif
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView()
    }
}
