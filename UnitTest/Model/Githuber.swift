//
//  Owner.swift
//  Gitz
//
//  Created by Anderson Oliveira on 28/10/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation

struct Githuber: Decodable {
    
    let photo: String
    let id: Int
    let name: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case photo = "avatar_url"
        case id
        case name = "login"
        case type
    }
}

extension Githuber: Hashable {
    
    
}
