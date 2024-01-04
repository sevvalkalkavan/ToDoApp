//
//  TaskDaoRepository.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import Foundation
import RxSwift

class TaskDaoRepository{
    var taskList = BehaviorSubject<[Task]>(value: [Task]())
    
    let db: FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("task.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func saveNewTask(title: String, subtitle: String, dueDate: String){
        //print("title: \(title) - subtitle: \(subtitle) - duedate: \(dueDate)")
        
        db?.open()
        
        do{
             try db!.executeUpdate("INSERT INTO task (title,subtitle,dueDate) VALUES (?,?,?) ", values: [title,subtitle,dueDate])

        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func delete(id: Int){
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM task WHERE id = ? ", values: [id])
            loadTask()
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func search(searchWord: String){
        db?.open()
        var list = [Task]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM task WHERE title like '%\(searchWord)%'", values: nil)
            while rs.next(){
                let task = Task(id: Int(rs.string(forColumn: "id"))!,
                                title: rs.string(forColumn: "title")!,
                                subtitle: rs.string(forColumn: "subtitle")!,
                                dueDate: rs.string(forColumn: "dueDate")!)
                list.append(task)
            }
            taskList.onNext(list)
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func loadTask(){
//        var list = [Task]()
//
//        let t1 = Task(id: 1, title: "First", subtitle: "FirstSubtitle", dueDate: "22/12/2023")
//        let t2 = Task(id: 2, title: "Second", subtitle: "SecondSubtitle", dueDate: "22/12/2023")
//        let t3 = Task(id: 3, title: "Third", subtitle: "ThirdSubtitle", dueDate: "22/12/2023")
//
//        list.append(t1)
//        list.append(t2)
//        list.append(t3)
//        taskList.onNext(list)
        
        db?.open()
        var list = [Task]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM task ", values: nil)
            while rs.next(){
                let task = Task(id: Int(rs.string(forColumn: "id"))!,
                                title: rs.string(forColumn: "title")!,
                                subtitle: rs.string(forColumn: "subtitle")!,
                                dueDate: rs.string(forColumn: "dueDate")!)
                list.append(task)
            }
            taskList.onNext(list)
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
}
