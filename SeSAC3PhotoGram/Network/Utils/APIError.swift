//
//  APIError.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

import Foundation

enum APIError: Error {
case badStatusCode(code: Int)
case noData
case unknown
}
