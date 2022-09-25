//
//  PhotosModel.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation

protocol PhotosModelProtocol: AnyObject{
    func didDataFetchProsessFinish(_ isSuccess: Bool)
}

class PhotosModel{
    weak var delegate: PhotosModelProtocol?
    
    var photos: [Photo] = []
    
    func fetchPhotoData(){
        
        //The function we pulled photos from API
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                self.delegate?.didDataFetchProsessFinish(false)
            }else if let data = data{
                do{
                    let photoList = try JSONDecoder().decode([Photo].self, from: data)
                    self.photos = photoList
                    self.delegate?.didDataFetchProsessFinish(true)
                }catch{
                    self.delegate?.didDataFetchProsessFinish(false)
                }
                
            }
            
        }.resume()
        
    }
}
