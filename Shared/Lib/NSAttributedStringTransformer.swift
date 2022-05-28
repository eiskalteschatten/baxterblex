//
//  NSAttributedStringTransformer.swift
//  Baxterblex
//
//  Created by Alex Seifert on 28.05.22.
//

import Foundation
import CoreData

@objc(NSAttributedStringTransformer)
class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSAttributedString.self]
    }
}
