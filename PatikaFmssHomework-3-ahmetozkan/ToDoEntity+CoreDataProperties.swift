//
//  ToDoEntity+CoreDataProperties.swift
//  
//
//  Created by Ahmet Ozkan on 23.09.2022.
//
//

import Foundation
import CoreData


extension ToDoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        return NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?

}
