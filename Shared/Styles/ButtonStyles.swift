//
//  ButtonStyles.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

struct RoundedFlatButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @State private var isHovering = false
    
    func makeBody(configuration: Configuration) -> some View {
        let hoverColor: Color = colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color(red: 0.85, green: 0.85, blue: 0.85)
        let pressedColor: Color = colorScheme == .dark ? Color(red: 0.18, green: 0.18, blue: 0.18) : Color(red: 0.82, green: 0.82, blue: 0.82)
        let backgroundColor = isHovering && !configuration.isPressed ? hoverColor : pressedColor
        
        configuration.label
            .buttonStyle(.plain)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(isHovering || configuration.isPressed ? backgroundColor : nil)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .onHover { hovering in
                isHovering = hovering
            }
    }
}

struct RoundedFlatTileButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @State private var isHovering = false
    
    func makeBody(configuration: Configuration) -> some View {
        let defaultColor: Color = colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.2) : Color(red: 0.85, green: 0.85, blue: 0.85)
        let pressedColor: Color = colorScheme == .dark ? Color(red: 0.18, green: 0.18, blue: 0.18) : Color(red: 0.82, green: 0.82, blue: 0.82)
        
        configuration.label
            .buttonStyle(.plain)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(configuration.isPressed ? pressedColor : defaultColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .onHover { hovering in
                isHovering = hovering
            }
    }
}
