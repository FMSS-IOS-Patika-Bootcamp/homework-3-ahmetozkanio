//
//  TabBarViewController.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadTabs()
        print("Tapbar")
    }

    private func loadTabs(){
        let postsViewStoryboard = UIStoryboard(name: "PostsView", bundle: nil)
        let postsViewController = postsViewStoryboard.instantiateInitialViewController()!
        
        let photosViewStoryboard = UIStoryboard(name: "PhotosView", bundle: nil)
        let photosViewController = photosViewStoryboard.instantiateInitialViewController()!
        
        let toDoViewStoryboard = UIStoryboard(name: "ToDoView", bundle: nil)
        let toDoViewController = toDoViewStoryboard.instantiateInitialViewController()!
    
        self.setViewControllers([postsViewController,photosViewController,toDoViewController], animated: true)
    }
    

}
