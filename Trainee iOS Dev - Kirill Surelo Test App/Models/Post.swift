//
//  Post.swift
//  test-app
//
//  Created by Кирилл Сурело on 03.08.2021.
//

import Foundation

struct Post: Decodable{
    var postId: Int?
    var timeshamp: Double?
    var title: String?
    var text: String?
    var images: [String]?
    var likes_count: Int?
}
