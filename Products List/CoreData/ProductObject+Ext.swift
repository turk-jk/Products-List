//
//  ProductObject+Ext.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import CoreData

extension ProductObject{
    static func findObject(id: String?, moc: NSManagedObjectContext) -> ProductObject? {
        guard let id = id else {return nil}
        let fetchRequest = ProductObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id LIKE %@", id)
        fetchRequest.fetchLimit = 1
        return try? moc.fetch(fetchRequest).first
    }
    static func findObjects(moc: NSManagedObjectContext) -> [ProductObject] {
        return (try? moc.fetch(ProductObject.fetchRequest())) ?? []
    }
}
