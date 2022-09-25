//
//  PhotosViewModel.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation
import Kingfisher

protocol PhotosViewModelViewProtocol: AnyObject{
    func didCellItemFetch(_ items:[PhotosCellViewModel])
}

class PhotosViewModel{
    private let photosModel = PhotosModel()
    
    weak var viewDelegate: PhotosViewModelViewProtocol?
    
    init(){
        photosModel.delegate = self
    }
    func didViewLoad(){
        photosModel.fetchPhotoData()
    }
    
}
private extension PhotosViewModel{
    func makeViewBasedModel(photos:[Photo]) -> [PhotosCellViewModel]{
        //mapped to CollectionViewCell
        return photos.map { .init(image: $0.thumbnailUrl)}
    }
}

extension PhotosViewModel: PhotosModelProtocol{
    func didDataFetchProsessFinish(_ isSuccess: Bool) {
        
        //If the photos came correctly, they are entered here from the api and these operations are done.
       
        if isSuccess{
            let photos = photosModel.photos
            let cellModels = makeViewBasedModel(photos: photos)
            viewDelegate?.didCellItemFetch(cellModels)
            
        }
    }
}
