//
//  APIConfig.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation
import Moya

private extension String {
    static let base: String = "https://api.producthunt.com/v2/api/graphql"
    static let contentType: String = "Content-Type"
    static let authorization: String = "Authorization"
    static let applicationJson = "application/json"
}

struct APIConfig {
    static let baseURL: URL = URL(.base)
    static let path: String = ""
    static let headers: [String: String] = [.contentType: .applicationJson,
                               .authorization: "Bearer Pmi_WfEQ_Ag4tNWbQtcF_qMl3mOlB3YKXuMp545JmUg"]
}

extension URL {
    init(_ string: String) {
        guard let instance = URL(string: string) else {
            fatalError("Unconstructable URL: \(string)")
        }
        self = instance
    }
}

extension Data {
    func resolve(for key: String) throws -> Data {
        do {
            let json = try JSONSerialization.jsonObject(with: self,
                                                        options: []) as? [String: AnyObject]
            let data = try JSONSerialization.data(withJSONObject: json?["data"]?[key] as Any, options: [])
            return data
        } catch {
            throw error
        }
    }
}
