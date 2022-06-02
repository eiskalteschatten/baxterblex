//
//  AbstractEditModel.swift
//  Baxterblex
//
//  Created by Alex Seifert on 24.05.22.
//

import Foundation
import CoreData

class AbstractEditModel: ObservableObject {
    var viewContext: NSManagedObjectContext?
    
    init() {
        viewContext = PersistenceController.shared.container.viewContext
    }
    
    func initVariables() {
        fatalError("Subclasses must implement the initVariables() function!")
    }
    
    func save() {
        fatalError("Subclasses must implement the save() function!")
    }
}
