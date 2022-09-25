//
//  ToDoAddViewController.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 23.09.2022.
//

import UIKit




class ToDoAddViewController: UIViewController,  UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    
    var toDo = ToDo()
    private let toDoModel = ToDoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toDoSaveButtonClick(_ sender: Any) {
        if titleTextField.text != nil {
            toDo.title = titleTextField.text
        }else{
            //ALERT
        }
        if contentTextField.text != nil{
            toDo.content = contentTextField.text
        }else{
            //ALERT
        }
        // The data in the textField is sent as a record to the CoreData
        toDoModel.saveToDoCoreData(toDo: toDo)
        navigationController?.popViewController(animated: true)
    }
}
