//
//  ToDoItemModel.swift
//  Todoey
//
//  Created by fmustafa on 12/15/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class ToDoItem: Encodable {
    var title: String
    var isDone: Bool

    init(title: String, isDone: Bool) {
        self.title = title
        self.isDone = isDone
    }
}
