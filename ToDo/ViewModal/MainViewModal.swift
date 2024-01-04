//
//  MainViewModal.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import Foundation
import RxSwift
class MainViewModal{
    var trepo = TaskDaoRepository()
    var taskList = BehaviorSubject<[Task]>(value: [Task]())
    
    init(){
        copyDatabase()
        taskList = trepo.taskList
        loadTask()
        
    }
    
    func delete(id:Int){
        trepo.delete(id: id)
    }
    func search(searchWord: String){
        trepo.search(searchWord: searchWord)
    }
    func loadTask(){
        trepo.loadTask()
    }
    
    
    func copyDatabase(){
        let bundleYolu = Bundle.main.path(forResource: "task", ofType: ".sqlite") //veritabnını uygulama içersine aktarıcak
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! //telefon içerisinde kayıt yapılcak yer seçilir
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("task.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{}
        }
    }
}
