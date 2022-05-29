//
//  RichTextEditor.swift
//  Baxterblex
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct RichTextEditor: View {
//    @Binding var text: NSAttributedString
    @Binding var text: String
    
    var body: some View {
        #if os(macOS)
        MacRichTextEditor(text: $text)
        #else
        iOSRichTextEditor(text: $text)
        #endif
    }
}

struct RichTextEditor_Previews: PreviewProvider {
//    @State static private var text = NSAttributedString(string: "Test")
    @State static private var text: String = ""

    static var previews: some View {
        RichTextEditor(text: $text)
    }
}
