//
//  AddViewModal.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import Foundation

class AddViewModal{
    var trepo = TaskDaoRepository()
    
    func saveNewTask(title: String, subtitle: String, dueDate: String){
        trepo.saveNewTask(title: title, subtitle: subtitle, dueDate: dueDate)
    }
}
