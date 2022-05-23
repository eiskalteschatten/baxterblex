//
//  EditGameSheet.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

struct EditGameSheet: View {
    @Binding var showEditSheet: Bool
       
    var body: some View {
        #if os(macOS)
        MacEditGameForm(showEditSheet: $showEditSheet)
        #else
        iOSEditGameForm(showEditSheet: $showEditSheet)
        #endif
    }
}

struct EditGameSheet_Previews: PreviewProvider {
    @State static var showEditSheet = false
    
    static var previews: some View {
        EditGameSheet(showEditSheet: $showEditSheet)
    }
}
