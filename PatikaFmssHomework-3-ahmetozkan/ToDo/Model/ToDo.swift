//
//  ToDoEntity.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 22.09.2022.
//

import Foundation
import UIKit

struct ToDoCellModel{
    var title: String
    var image: UIImage
}

struct ToDo{
    var id: UUID?
    var title: String?
    var content: String?
    var isCompleted: Bool?
    var date: Date?
}
