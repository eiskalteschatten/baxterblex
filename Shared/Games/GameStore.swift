//
//  GameStore.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

final class GameStore: ObservableObject {
    // Games
    @Published var selectedGame: Game?
    @Published var showEditGameSheet: Bool = false
    
    // Characters
    @Published var selectedCharacter: Character?
    @Published var createCharacter: Bool = false
}
