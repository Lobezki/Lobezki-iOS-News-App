//
//  Post.swift
//  test-app
//
//  Created by Кирилл Сурело on 01.08.2021.
//

import Foundation

struct PreviewPost: Decodable{
    var postId: Int?
    var timeshamp: Double?
    var title: String?
    var preview_text: String?
    var likes_count: Int?
}
