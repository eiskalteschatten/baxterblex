//
//  DateHelpers.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import Foundation

func formatDateLong(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    return dateFormatter.string(from: date)
}
