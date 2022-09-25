//
//  ToDoViewController.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation
import UIKit

class ToDoViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    private let toDoViewModel = ToDoViewModel()
    private var items: [ToDoCellModel] = []
    private var toDoAddViewController = ToDoAddViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        toDoViewModel.toDoViewModelDelegate = self
        toDoViewModel.didViewLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        // On the other hand, we report what we added here and call getCoreData again.
        NotificationCenter.default.addObserver(self, selector: #selector(getToDoViewWillAppear), name: NSNotification.Name(rawValue: "newToDoData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getToDoViewWillAppear), name: NSNotification.Name(rawValue: "toDoIsCompleted"), object: nil)
    }
    
    //The tableview is repopulated with the function triggered from the ViewModel
    @objc func getToDoViewWillAppear(){
        toDoViewModel.didViewLoad()
    }
    
    
    @IBAction func toDoAddButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "toToDoAdd", sender: nil)//rooting islemi
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toToDoDetail" {
            if let destinationVC = segue.destination as? ToDoDetailViewController{
                //the model on page a has been sent
                destinationVC.toDoItem = toDoViewModel.selectedItem
            }
        }
    }
}


extension ToDoViewController: ToDoViewModelDelegate{
    func didToDoCellItemFetch(_ toDoItems: [ToDoCellModel]) {
        
        self.items.removeAll() //items are deleted on resummon
        self.items = toDoItems
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
private extension ToDoViewController{
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell()
    }
    func registerTableViewCell(){
        tableView.register(.init(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
    }
}


extension ToDoViewController: UITableViewDelegate{
    
}
extension ToDoViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count > 0 ? items.count : 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoViewModel.didClickItem(at: indexPath.row)
        performSegue(withIdentifier: "toToDoDetail", sender: nil)//rooting islemi
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as? ToDoTableViewCell
        
       // The data in the tableView Cell is filled here and the title and image are added
        
        cell?.titleLabel.text = items[indexPath.row].title
        cell?.imageView?.image = items[indexPath.row].image
        
        return cell!
        
    }
    
    
    
    
}
