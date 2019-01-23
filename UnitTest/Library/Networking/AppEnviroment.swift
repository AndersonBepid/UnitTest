//
//  AppEnviroment.swift
//  Gitz
//
//  Created by Anderson Oliveira on 28/10/18.
//  Copyright (c) 2018 Anderson Oliveira. All rights reserved.
//

import Foundation

enum AppEnviroment {

    case gitz

    var workspacesURL: String {
        switch self {
        case .gitz:
            return "https://api.github.com"
        }
    }
}
