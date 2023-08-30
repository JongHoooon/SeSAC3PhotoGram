//
//  APIService.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

import Foundation

final class APIService {
    
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
}
