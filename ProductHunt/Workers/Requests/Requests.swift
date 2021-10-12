//
//  Requests.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 26/09/2021.
//

import Moya

enum Requests {
    case fetchList(after: String?)
    case fetchPost(post: String)
    case fetchUser(user: String)
    case fetchPostsForUser(user: String, after: String?)
}

extension Requests: TargetType {
    var baseURL: URL {
        return APIConfig.baseURL
    }

    var path: String {
        return APIConfig.path
    }

    var method: Method {
        return .post
    }

    var task: Task {
        switch self {
        case .fetchList(let after):
            let data = Data(GraphQLBuilder.posts(after: after).data)
            return .requestData(data)
        case .fetchPost(let identifier):
            let data = Data(GraphQLBuilder.post(identifier: identifier).data)
            return .requestData(data)
        case .fetchUser(let identifier):
            let data = Data(GraphQLBuilder.user(identifier: identifier).data)
            return .requestData(data)
        case .fetchPostsForUser(let identifier, let after):
            let data = Data(GraphQLBuilder.postsForUser(identifier: identifier, after: after).data)
            return .requestData(data)
        }
    }

    var headers: [String: String]? {
        return APIConfig.headers
    }
}

extension Data {
    init(_ data: Data?) {
        guard let data = data else {
            fatalError("Invalid data")
        }
        self = data
    }
}
