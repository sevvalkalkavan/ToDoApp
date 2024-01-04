//
//  DetailViewController.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var duedateLabel: UILabel!
    
   
    var task: Task?
    
    var viewModal = DetailViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let t = task{
            print("Task title: \(t.title ?? "nil"), subtitle: \(t.subtitle ?? "nil"), dueDate: \(t.dueDate ?? "nil")")

            titleLabel.text = t.title
            subtitleLabel.text = t.subtitle
            duedateLabel.text = t.dueDate
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
