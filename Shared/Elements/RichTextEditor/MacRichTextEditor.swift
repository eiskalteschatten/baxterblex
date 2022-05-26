//
//  MacRichTextEditor.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct MacRichTextEditor: NSViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var textView = NSTextView()
    
    @Binding var text: NSAttributedString
    
    func makeNSView(context: Context) -> NSTextView {
        textView.delegate = context.coordinator
        textView.isRichText = true
        textView.allowsUndo = true
        textView.allowsImageEditing = false
        
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.textStorage?.setAttributedString(text)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: MacRichTextEditor
        var affectedCharRange: NSRange?
        
        init(_ parent: MacRichTextEditor) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.attributedString()
        }
        
        func textView(_ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?) -> Bool {
            return true
        }
    }
}
