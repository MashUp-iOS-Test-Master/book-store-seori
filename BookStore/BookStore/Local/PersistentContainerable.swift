//
//  PersistentContainerable.swift
//  BookStore
//
//  Created by Seori on 2022/10/22.
//

import Foundation
import CoreData

protocol PersistentContainerable: AnyObject {
    var context: ManagedObjectContextable { get }
}

extension NSPersistentContainer: PersistentContainerable {
    var context: ManagedObjectContextable {
        self.viewContext
    }
}

protocol ManagedObjectContextable: AnyObject {
    func save() throws
    func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any]
    func delete(_ object: NSManagedObject)
}

extension NSManagedObjectContext: ManagedObjectContextable {
    
}
