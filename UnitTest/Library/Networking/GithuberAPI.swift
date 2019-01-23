//
//  OwnerAPI.swift
//  Gitz
//
//  Created by Anderson Moura de Oliveira on 28/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation

enum GithuberAPI {
    case fetch
}

extension GithuberAPI {
    
    var path: String {
        switch self {
        case .fetch: return "/users"
        }
    }

    var httpMethod: String {
        switch self {
        case .fetch:
            return "GET"
        }
    }
    
    var urlComponents: URLComponents? {
        return URLComponents(string: AppEnviroment.gitz.workspacesURL + path)
    }
}
