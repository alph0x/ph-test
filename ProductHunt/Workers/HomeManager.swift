//
//  HomeManager.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Moya
import SwiftyUtils

final class HomeManager {

    let provider = MoyaProvider<Requests>()

    func fetchPosts(from cursor: String? = nil,
                    onCompletion: @escaping ((Result<[PostEdge], Error>) -> Void)) {
        perform(.fetchList(after: cursor)) { result in
            switch result {
            case .success(let response):
                do {
                let data = try response.data.resolve(for: "posts")
                let connection = try JSONDecoder().decode(PostConnection.self, from: data)
                    onCompletion(.success(connection.edges))
                } catch {
                    onCompletion(.failure(error))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }

    func perform(_ request: Requests,
                 onCompletion: @escaping ((Result<Response, MoyaError>) -> Void)) {
        provider.request(request) { onCompletion($0) }
    }
}
