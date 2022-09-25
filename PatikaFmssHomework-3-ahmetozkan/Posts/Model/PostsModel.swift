//
//  PostsModel.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation


protocol PostsModelProtocol: AnyObject{
    func didDataFetchProsessFinish(_ isSuccess: Bool)
}

class PostsModel{
    
    weak var delegate: PostsModelProtocol?
    
    var posts: [Post] = []
    
    func fetchPostData(){
        
        // That is taken by the posts api
        
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else{
            delegate?.didDataFetchProsessFinish(false)
            return
        }
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        let _ = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.delegate?.didDataFetchProsessFinish(false)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            guard statusCode! == 200 else{
                self.delegate?.didDataFetchProsessFinish(false)
                return
            }
            
            guard let data = data else {
                self.delegate?.didDataFetchProsessFinish(false)
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                self.posts = try jsonDecoder.decode([Post].self, from: data)
                self.delegate?.didDataFetchProsessFinish(true)
            }catch{
                self.delegate?.didDataFetchProsessFinish(false)
            }
        }.resume()
        
    }
}
