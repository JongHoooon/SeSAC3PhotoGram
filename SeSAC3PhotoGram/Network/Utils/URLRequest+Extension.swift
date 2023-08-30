//
//  URLRequest+Extension.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

import Foundation

extension URLRequest {
    mutating func addHeaders(headers: [HTTPHeader]?) {
        headers?.forEach { httpHeader in
            addValue(httpHeader.value, forHTTPHeaderField: httpHeader.name)
        }
    }
}
