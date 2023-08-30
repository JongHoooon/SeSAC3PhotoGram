//
//  HTTPHeader.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

struct HTTPHeader {
    let name: String
    let value: String
    
    init(
        name: String,
        value: String
    ) {
        self.name = name
        self.value = value
    }
}

extension HTTPHeader {
    static let accept = HTTPHeader(name: "accept", value: "application/json")
    static let authorization = HTTPHeader(name: "Authorization", value: "Client-ID \(APIKey.acessKey)")
}

