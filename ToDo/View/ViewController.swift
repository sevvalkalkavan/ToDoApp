//
//  ViewController.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var taskList = [Task]()
    
    var viewModal = MainViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        let t1 = Task(id: 1, title: "First", subtitle: "FirstSubtitle", dueDate: "22/12/2023")
        let t2 = Task(id: 2, title: "Second", subtitle: "SecondSubtitle", dueDate: "22/12/2023")
        let t3 = Task(id: 3, title: "Third", subtitle: "ThirdSubtitle", dueDate: "22/12/2023")
        
        taskList.append(t1)
        taskList.append(t2)
        taskList.append(t3)
        
        _ = viewModal.taskList.subscribe(onNext: { list in
            self.taskList = list
            self.taskTableView.reloadData()
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModal.loadTask()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            if let task = sender as? Task{
                let toVC = segue.destination as! DetailViewController
                toVC.task = task
            }
        }
    }

}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModal.search(searchWord: searchText)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = taskList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCell
        
        cell.titleLabel.text = task.title
        cell.dueDateLabel.text = task.dueDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: task)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Delete"){_,_,_ in
           
            let task = self.taskList[indexPath.row]//hangi kişi oldupunu anlama
            
            let alert = UIAlertController(title: "Delete", message: "\(task.title!)", preferredStyle: UIAlertController.Style.alert)
            let iptalAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(iptalAction)
            
            let eventAction = UIAlertAction(title: "OK", style: .destructive){ action in
                //print(kisi.kisi_id!)
                self.viewModal.delete(id: task.id!)
               
            }
            
            alert.addAction(eventAction)
            
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
        
    }
    
    
}

