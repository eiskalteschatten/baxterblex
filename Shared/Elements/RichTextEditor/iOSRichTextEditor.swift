//
//  iOSRichTextEditor.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct iOSRichTextEditor: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var textView = UITextView()
    
    @Binding var text: NSAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }

    class Coordinator: NSObject, UITextViewDelegate{
        var parent: iOSRichTextEditor
        var affectedCharRange: NSRange?
        
        init(_ parent: iOSRichTextEditor) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? UITextView else {
                return
            }
            
            self.parent.text = textView.attributedText
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn affectedCharRange: NSRange, replacementText replacementString: String) -> Bool {
            return true
        }
    }
}
