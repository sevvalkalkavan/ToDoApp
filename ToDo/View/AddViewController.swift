//
//  AddViewController.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var subtitleTF: UITextView!
    @IBOutlet weak var dueDateTF: UITextField!
    
    var viewModal = AddViewModal()
    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dueDateTF.inputView = datePicker
        
        let getGesture = UITapGestureRecognizer(target: self, action: #selector(gestureRecognize))
        view.addGestureRecognizer(getGesture)
        datePicker?.addTarget(self, action: #selector(getDate(uiDatePicker:)), for: .valueChanged)
        if #available (iOS 13.4, *){
            datePicker?.preferredDatePickerStyle = .wheels
        }
        // Do any additional setup after loading the view.
    }
    

    @objc func gestureRecognize(){
        print("touched")
        view.endEditing(true)
    }
    
    @objc func getDate(uiDatePicker: UIDatePicker){
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        let currentDate = format.string(from: uiDatePicker.date)
        dueDateTF.text = currentDate
    }
    


    @IBAction func saveButtonPressed(_ sender: Any) {
        viewModal.saveNewTask(title: titleTF.text!, subtitle: subtitleTF.text!, dueDate: dueDateTF.text!)
    }
    

}
