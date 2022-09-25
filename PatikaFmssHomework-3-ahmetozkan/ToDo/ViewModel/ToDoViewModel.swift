//
//  ToDoViewModel.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 22.09.2022.
//


import Foundation
import UIKit

protocol ToDoViewModelDelegate: AnyObject{
    func didToDoCellItemFetch(_ toDoItems:[ToDoCellModel])
}
protocol ToDoDetailProtocol: AnyObject{
    func setupUIDetailView(_ toDo: ToDo)
}
class ToDoViewModel{
    
    weak var toDoViewModelDelegate: ToDoViewModelDelegate?
    weak var toDoDetailProtocol: ToDoDetailProtocol?
    
    var toDoModel = ToDoModel()
    var toDoDetail = ToDoDetailViewController()
    var selectedItem: ToDo?
    
    init(){
        toDoModel.toDoModelDelegate = self
    }
    func didViewLoad(){
        //Recalling from CoreData is done here
        toDoModel.getFetchToDoCoreData()
    }
    func didClickItem(at index: Int){
        //Triggers index click event in TableView
        selectedItem = toDoModel.toDo[index]
    }
}
extension ToDoViewModel{
    func makeViewBasedModel(toDoList:[ToDo]) -> [ToDoCellModel]{
        
        //TableViewCell individual rows are sent as a list
        
        return toDoList.map{ .init(title: $0.title ?? "", image: isCompletedRowImageStyle($0.isCompleted ?? false)) }
    }
    func isCompletedRowImageStyle(_ isCompleted: Bool) -> UIImage{
        
        //With the bool value IsCompleted, it is determined how to set the view in the TableViewCell
        
        if isCompleted{
            let isCheckImage = UIImage(systemName: "checkmark.circle.fill")!.withTintColor(.green, renderingMode: .alwaysOriginal)

            return isCheckImage
        }else{
            let isCheckImage =  UIImage(systemName: "xmark.app.fill")!.withTintColor(.red, renderingMode: .alwaysOriginal)
            return isCheckImage
        }
    }
}

extension ToDoViewModel: ToDoModelDelegateProtocol{
    // After the data we use with Delegate is brought, the actions are done here.
    func didFetchToDoCoreData(_ isSuccess: Bool) {
        if isSuccess{
            print("CoreData")
            let toDoList = toDoModel.toDo
            let cellModels = makeViewBasedModel(toDoList: toDoList)
            toDoViewModelDelegate?.didToDoCellItemFetch(cellModels)
        }
    }
}
