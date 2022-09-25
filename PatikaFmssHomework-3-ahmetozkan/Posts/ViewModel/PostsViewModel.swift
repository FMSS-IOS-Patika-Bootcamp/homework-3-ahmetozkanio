//
//  PostViewModel.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation


protocol PostsViewModelViewProtocol: AnyObject{
    func didCellItemFetch(_ items:[PostsCellViewModel])
 
}

class PostsViewModel{
    
    private let model = PostsModel()
    weak var viewDelegate: PostsViewModelViewProtocol?
    
    init(){
        model.delegate = self
    }
    func didViewLoad(){
        model.fetchPostData()
    }
}

private extension PostsViewModel{
    @discardableResult
    func makeViewBasedModel(_ posts: [Post]) -> [PostsCellViewModel] {
        
        
       // TableView Cell's used items are created here
        return posts.map{
            .init(title: $0.title, body: $0.body)
        }
    }
}

extension PostsViewModel: PostsModelProtocol{
    func didDataFetchProsessFinish(_ isSuccess: Bool){
        
        // If PostApi is successful, the function here is triggered and the operations here are done.
        
        if isSuccess{
            let posts = model.posts
            let cellModels = makeViewBasedModel(posts)
            viewDelegate?.didCellItemFetch(cellModels)
     
        }
    }
}

