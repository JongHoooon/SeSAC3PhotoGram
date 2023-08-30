//
//  PhotoAPI.swift
//  SeSAC3PhotoGram
//
//  Created by JongHoon on 2023/08/30.
//

import Foundation

enum PhotoAPI {
    case searchPhoto(query: String)
    
    var url: String 
}
