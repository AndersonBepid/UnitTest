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
    var provider: GithuberWorker!
    
    convenience init(delegate: GithubersPresenterDelegate, provider: GithuberWorker = GithuberWorker.singleton) {
        self.init()
        self.delegate = delegate
        self.provider = provider
    }

    func fetchAllGithubers() {
        provider.fetch { (result) in
            self.delegate?.displayGithubers(result: result)
        }
    }
}
