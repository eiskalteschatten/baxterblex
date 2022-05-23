//
//  GameStore.swift
//  Baxterblex
//
//  Created by Alex Seifert on 23.05.22.
//

import SwiftUI

final class GameStore: ObservableObject {
    @Published var selectedGame: Game?
}
