//
//  Category.swift
//  Todoey
//
//  Created by Yi Ting Lu on 2019/9/6.
//  Copyright © 2019 Yi Ting Lu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
