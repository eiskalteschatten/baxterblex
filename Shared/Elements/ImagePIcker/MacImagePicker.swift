//
//  MacImagePicker.swift
//  Baxterblex (macOS)
//
//  Created by Alex Seifert on 29.05.22.
//

import SwiftUI

struct MacImagePicker {
    static func pickImage() -> (response: NSApplication.ModalResponse, panel: NSOpenPanel) {
        let panel = NSOpenPanel()
        panel.prompt = "Choose Image"
        panel.worksWhenModal = true
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.image]
        panel.allowsMultipleSelection = false
        return (panel.runModal(), panel)
    }
}
