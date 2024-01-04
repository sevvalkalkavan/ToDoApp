//
//  Task.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import Foundation

class Task{
    var id: Int?
    var title: String?
    var subtitle: String?
    var dueDate: String?
    
    init(id: Int,title: String, subtitle: String, dueDate: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.dueDate = dueDate
    }
}
