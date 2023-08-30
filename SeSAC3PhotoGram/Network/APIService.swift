//
//  APIService.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

import Foundation

final class APIService: RequestCallable {
    typealias API = PhotoAPI
    
    static let shared = APIService()    // 인스턴스 생성 방지
    private init() {}
    
    func callRequest() {

        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_1080.jpg")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { data, response, error in
                print(data)
                let value = String(data: data ?? Data(), encoding: .utf8)
                print(value)
                print(response)
                print(error)
            }
        )
        .resume()
    }
    
    func requstCall<T: Decodable>(
        of: T.Type, api: PhotoAPI,
        result: @escaping (Result<T, Error>) -> Void
    ) {
        URLSession.shared
            .dataTask(
                with: api.request,
                completionHandler: { data, response, error in
                    if let error = error {
                        result(.failure(error))
                        return
                    }
                    if let httpResponse = response as? HTTPURLResponse,
                       !(200..<300 ~= httpResponse.statusCode) {
                        result(.failure(APIError.badStatusCode(code: httpResponse.statusCode)))
                    }
                    guard let data = data else {
                        result(.failure(APIError.noData))
                        return
                    }
                    
                    do {
                        let value = try JSONDecoder().decode(of, from: data)
                        result(.success(value))
                    } catch {
                        result(.failure(error))
                    }
                }
            )
            .resume()
    }
}

protocol RequestCallable {
    associatedtype API: APIable
    
    func requstCall<T: Decodable>(
        of: T.Type,
        api: API,
        result: @escaping (Result<T, Error>) -> Void
    )
}
