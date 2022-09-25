//
//  ToDoDetailViewController.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 24.09.2022.
//

import UIKit


class ToDoDetailViewController: UIViewController {
  
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var isCompleted: UIButton!
 
    var toDoItem: ToDo?
    var toDoModel = ToDoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        setup()
    }
  
    @IBAction func isCompletedButtonClick(_ sender: Any) {
        toDoModel.isCompletedSaved(toDoItem!.id!)
        navigationController?.popViewController(animated: true)
    }
    
    func setup() {
        // Filling the data from the TableViewCell is done in the setup function.
        imageView.image = ToDoViewModel().isCompletedRowImageStyle(toDoItem?.isCompleted ?? false)
        titleLabel.text = toDoItem?.title
        contentLabel.text = toDoItem?.content
        if !(toDoItem?.isCompleted)!   {
            // The isCompleted button in the detailed toDo is disabled.
            isCompleted.isHidden = true
        }
    }
}
