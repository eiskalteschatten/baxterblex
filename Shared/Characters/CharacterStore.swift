//
//  CharacterStore.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import SwiftUI

final class CharacterStore: ObservableObject {
    @Published var selectedCharacter: Character?
}

