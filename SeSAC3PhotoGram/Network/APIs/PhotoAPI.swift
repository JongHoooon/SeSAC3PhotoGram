//
//  PhotoAPI.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

import Foundation

enum PhotoAPI: APIable {
    case searchPhoto(query: String)

    var url: String {
        let baseURL = Endpoint.baseURL
        switch self {
        case .searchPhoto:
            return baseURL+"/search/photos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchPhoto:              return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .searchPhoto(query: query):
            return [URLQueryItem(name: "query", value: query)]
        }
    }
    
    var header: [HTTPHeader]? {
        switch self {
        case .searchPhoto:
            return [.accept, .authorization]
        }
    }
    
    var request: URLRequest {
        switch self {
        case .searchPhoto:
            var url = URL(string: url)!
            url.append(queryItems: queryItems ?? [])
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.addHeaders(headers: header)
            return request
        }
    }
}
