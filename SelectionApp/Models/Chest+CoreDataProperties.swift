//
//  Chest+CoreDataProperties.swift
//  SelectionApp
//
//  Created by Muhammed Emin Bardakcı on 16.05.2023.
//
//

import Foundation
import CoreData


extension Chest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chest> {
        return NSFetchRequest<Chest>(entityName: "Chest")
    }

    @NSManaged public var chestNumber: String?
    @NSManaged public var rteCount: Int16
    @NSManaged public var kkCount: Int16

}

extension Chest : Identifiable {

}
