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
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textView.frame.size.width, height: 44))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", image: nil, primaryAction: UIAction { action in
            context.coordinator.cancelButtonTapped(action: action)
        })
        let clearButton = UIBarButtonItem(title: "Clear", image: nil, primaryAction: UIAction(handler: context.coordinator.clearButtonTapped(action:)))
        let doneButton = UIBarButtonItem(title: "Done", image: nil, primaryAction: context.coordinator.doneAction)

        toolbar.setItems([cancelButton, spacer, clearButton, spacer, doneButton], animated: true)
        textView.inputAccessoryView = toolbar
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: iOSRichTextEditor
        var affectedCharRange: NSRange?
        lazy var doneAction = UIAction(handler: doneButtonTapped(action:))
        
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
        
        func cancelButtonTapped(action: UIAction) -> Void {
           print("Cancel Button Tapped")
        }

        func clearButtonTapped(action: UIAction) -> Void {
           print("Clear Button Tapped")
        }

        private func doneButtonTapped(action: UIAction) -> Void {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
