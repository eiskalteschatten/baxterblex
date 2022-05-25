//
//  ResizableText.swift
//  Baxterblex
//
//  Created by Alex Seifert on 25.05.22.
//

import SwiftUI

struct ResizableText: View {
    var text: String
    
    init (_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ResizableText_Previews: PreviewProvider {
    static var previews: some View {
        ResizableText("Some text here")
    }
}
