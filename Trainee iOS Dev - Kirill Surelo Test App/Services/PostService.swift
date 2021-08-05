//
//  PostsService.swift
//  test-app
//
//  Created by Кирилл Сурело on 02.08.2021.
//

import Foundation

struct PostsJSON: Decodable {
    var posts: [PreviewPost]
}

struct PostJSON: Decodable {
    var post: Post
}

final class PostService {
    private init () {}
    
    static let shared = PostService()

    let session = URLSession.shared
    
    func getPosts(completion: @escaping (([PreviewPost]) -> Void)) {

        let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/main.json"
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
                case .success(let data):
                    let posts = self.parsePostsList(jsonData: data)?.posts
                    completion(posts!)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getPost(postId: Int, completion: @escaping ((Post) -> Void)) {
        
        let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/posts/\(postId).json"
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
                case .success(let data):
                    if let post = self.parsePost(jsonData: data)?.post {
                        completion(post)
                    } else {
                        completion(Post(postId: postId, timeshamp: Date().timeIntervalSince1970, title: "Ошибка 404", text: "Страница не найдена", images: [], likes_count: 0))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                }
            }
            
            urlSession.resume()
        }
    }
    
    private func parsePostsList(jsonData: Data) -> PostsJSON? {
        do {
            let decodedData = try JSONDecoder().decode(PostsJSON.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        
        return nil
    }
    
    private func parsePost(jsonData: Data) -> PostJSON? {
        do {
            let decodedData = try JSONDecoder().decode(PostJSON.self, from: jsonData)
            print("==================parsePost=================")
            print(decodedData)
            return decodedData
        } catch {
            print("decode error")
        }
        
        return nil
    }
}
