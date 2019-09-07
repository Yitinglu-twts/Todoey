//
//  Item.swift
//  Todoey
//
//  Created by Yi Ting Lu on 2019/9/6.
//  Copyright © 2019 Yi Ting Lu. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
