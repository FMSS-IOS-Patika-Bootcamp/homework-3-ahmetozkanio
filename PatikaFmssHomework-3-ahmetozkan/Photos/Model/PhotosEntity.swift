//
//  PhotosEntity.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation
import UIKit


struct PhotosCellViewModel{
    var image: String
}

struct Photo: Decodable{
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}

