//
//  ToDoModel.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 22.09.2022.
//

import Foundation
import CoreData
import UIKit

protocol ToDoModelDelegateProtocol:AnyObject{
    func didFetchToDoCoreData(_ isSuccess: Bool)
    
}

class ToDoModel{
    
    weak var toDoModelDelegate: ToDoModelDelegateProtocol?
    var toDo: [ToDo] = []
    
    let entityName = "ToDoEntity"
    
    //used to pull data from core data
    func getFetchToDoCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            //data from core data
            if results.count > 0{
             
                toDo.removeAll()//on re-call the list is deleted
                for result in results as! [NSManagedObject]{
                    //Passing data to the toDo model
                    toDo.append(
                        ToDo(id: result.value(forKey: "id") as? UUID , title: result.value(forKey: "title") as? String, content: result.value(forKey: "content") as? String, isCompleted: result.value(forKey: "isCompleted") as? Bool, date: result.value(forKey: "date") as? Date)
                    )
                }
                toDo.reverse()//reverses the data and goes to the last added top
                self.toDoModelDelegate?.didFetchToDoCoreData(true)
            }
        }
        catch {
            print("Error")
        }
    }
    //ToDo recording process
    func saveToDoCoreData(toDo: ToDo){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newToDo = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        // Converting the incoming todo object to the way core data will handle
        newToDo.setValue(UUID(), forKey: "id")
        newToDo.setValue(toDo.title, forKey: "title")
        newToDo.setValue(toDo.content, forKey: "content")
        newToDo.setValue(true, forKey: "isCompleted")
        newToDo.setValue(Date.now, forKey: "date")
        
        do{
            try context.save()

            // Declaring the save action with NotificationCenter
            NotificationCenter.default.post(name: NSNotification.Name("newToDoData"), object: nil)
            print("success")
        } catch{
            
            print("Error")
        }
    }
    
    // The user is activated by the button to complete their todo
    func isCompletedSaved(_ id: UUID){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let idString = id.uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false

        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                
                let objectUpdate = results[0] as! NSManagedObject
                objectUpdate.setValue(false, forKey: "isCompleted") // isCompleted set to false
                
                try context.save()
                // Declaring the change action with NotificationCenter
                NotificationCenter.default.post(name: NSNotification.Name("toDoIsCompleted"), object: nil)
            }
            
        } catch{
            
            print("Error")
        }
    }
    
    
}




