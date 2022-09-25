//
//  PostsEntity.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation


struct PostsCellViewModel{
    var title: String?
    var body: String?
}

struct Post: Decodable{
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
