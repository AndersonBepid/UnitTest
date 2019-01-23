//
//  File.swift
//  UnitTest
//
//  Created by Anderson Moura de Oliveira on 22/01/19.
//  Copyright © 2019 Zup. All rights reserved.
//

import Foundation

protocol GithubersPresenterDelegate: class {
    func displayGithubers(result: Result<Githubers>)
}

class GithubersPresenter {
    
    weak var delegate: GithubersPresenterDelegate?
    let provider: GithuberWorker = GithuberWorker.singleton
    
    convenience init(delegate: GithubersPresenterDelegate) {
        self.init()
        self.delegate = delegate
    }

    func fetchAllGithubers() {
        provider.fetch { (result) in
            self.delegate?.displayGithubers(result: result)
        }
    }
}
