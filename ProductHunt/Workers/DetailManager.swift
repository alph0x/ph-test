//
//  DetailManager.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Moya
import SwiftyUtils

final class DetailManager {

    let provider = MoyaProvider<Requests>()

    func fetchPost(_ identifier: String,
                   onCompletion: @escaping ((Result<Post, Error>) -> Void)) {
        perform(.fetchPost(post: identifier)) { result in
            switch result {
            case .success(let response):
                do {
                    let data: Data = try response.data.resolve(for: "post")
                    let object = try JSONDecoder().decode(Post.self, from: data)
                    onCompletion(.success(object))
                } catch {
                    onCompletion(.failure(error))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }

    func fetchUser(_ identifier: String,
                   onCompletion: @escaping ((Result<User, Error>) -> Void)) {
        perform(.fetchUser(user: identifier)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.data.resolve(for: "user")
                    let object = try JSONDecoder().decode(User.self, from: data)
                    onCompletion(.success(object))
                } catch {
                    onCompletion(.failure(error))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }

    }

    func fetchPosts(for user: String,
                    after cursor: String?,
                    onCompletion: @escaping ((Result<User, Error>) -> Void)) {
        perform(.fetchPostsForUser(user: user, after: cursor)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.data.resolve(for: "user")
                    let object = try JSONDecoder().decode(User.self, from: data)
                    onCompletion(.success(object))
                } catch {
                    onCompletion(.failure(error))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }

    private func perform(_ request: Requests,
                         onCompletion: @escaping ((Result<Response, MoyaError>) -> Void)) {
        provider.request(request) { onCompletion($0) }
    }
}
