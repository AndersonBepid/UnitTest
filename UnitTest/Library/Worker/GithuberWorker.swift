//
//  OwnerWorker.swift
//  Gitz
//
//  Created by Anderson Moura de Oliveira on 28/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation

typealias Githubers = [Githuber]

enum Result<T> {
    case success(T)
    case failure(NSError)
}

class GithuberWorker {
    
    static let singleton = GithuberWorker()
    
    func fetch(_ completion: @escaping (_ searchResults: Result<Githubers>) -> Void) {
        let ownerAPI = GithuberAPI.fetch
        
        guard let urlComponents = ownerAPI.urlComponents else { return }
        guard let url = urlComponents.url else { return }

        var request = URLRequest(url: url)
        request.httpMethod = ownerAPI.httpMethod
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(error! as NSError))
                return
            }
            guard let data = data else {
                completion(.success([]))
                return
            }
            do {
                let owner = try JSONDecoder().decode(Githubers.self, from: data)
                completion(.success(owner))
            } catch {
                completion(.failure(error as NSError))
            }
        }
        task.resume()
    }
}
