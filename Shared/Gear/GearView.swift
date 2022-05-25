//
//  GearView.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct GearView: View {
    var body: some View {
        #if os(iOS)
        iOSGearView()
        #else
        MacGearView()
        #endif
    }
}

struct GearView_Previews: PreviewProvider {
    static var previews: some View {
        GearView()
    }
}
