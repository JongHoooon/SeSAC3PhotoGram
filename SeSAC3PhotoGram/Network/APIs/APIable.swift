//
//  APIable.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

import Foundation

protocol APIable {
    var url: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var header: [HTTPHeader]? { get }
    var request: URLRequest { get }
    
}
