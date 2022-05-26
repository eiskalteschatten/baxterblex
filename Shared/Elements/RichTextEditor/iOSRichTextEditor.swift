//
//  iOSRichTextEditor.swift
//  Baxterblex (iOS)
//
//  Created by Alex Seifert on 26.05.22.
//

import SwiftUI

struct iOSRichTextEditor: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
    var textView = UITextView()
    
    @Binding var text: NSAttributedString
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        textView.delegate = context.coordinator
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textView.frame.size.width, height: 44))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
//        let boldButton = UIBarButtonItem(title: "Bold", image: UIImage(systemName: "bold"), primaryAction: context.coordinator.boldAction)
        let doneButton = UIBarButtonItem(title: "Done", image: nil, primaryAction: context.coordinator.doneAction)

        toolbar.setItems([/*boldButton,*/ spacer, doneButton], animated: true)
        textView.inputAccessoryView = toolbar
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.backgroundColor = colorScheme == .dark ? UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6) : UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.8)
        uiView.attributedText = text
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: iOSRichTextEditor
        var affectedCharRange: NSRange?
        
//        lazy var boldAction = UIAction(handler: boldButtonTapped(action:))
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
        
//        private func boldButtonTapped(action: UIAction) -> Void {
//            let textRange = self.parent.textView.selectedRange
//            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]
//
//            if textRange.length > 0 {
//                let ass = NSAttributedString(string: self.parent.text.string, attributes: attributes)
//                self.parent.text = ass
//            }
//            else {
//                // TODO: bold all text that comes afterwards
//            }
//        }

        private func doneButtonTapped(action: UIAction) -> Void {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
