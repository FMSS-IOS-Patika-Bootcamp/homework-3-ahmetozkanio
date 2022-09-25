//
//  PostsViewController.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation
import UIKit

class PostsViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PostsViewModel()
    private var items: [PostsCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PostView")
        setupUI()
        viewModel.viewDelegate = self
        viewModel.didViewLoad()
    }
}



private extension PostsViewController{
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    func registerCell(){
        tableView.register(.init(nibName: "PostsViewTableViewCell", bundle: nil), forCellReuseIdentifier: "PostsViewTableViewCell")
    }
}

extension PostsViewController: PostsViewModelViewProtocol{
    
    
    func didCellItemFetch(_ items: [PostsCellViewModel]) {
        self.items = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func showEmptyView() {
        // TODO :
    }
    
    func hideEmptyView() {
        // TODO :
    }
    
    
}

extension PostsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // viewModel.didPostsClickItem(at: indexPath.row)
        
    }
}
extension PostsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsViewTableViewCell") as? PostsViewTableViewCell
        
        //TableViewCell used items are sent here
        
        cell?.titleLabel.text = items[indexPath.row].title
        cell?.bodyLabel.text = items[indexPath.row].body
        
        
        return cell!
        
        
        
        
    }
    
}

