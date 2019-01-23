//
//  ViewController.swift
//  UnitTest
//
//  Created by Anderson Moura de Oliveira on 22/01/19.
//  Copyright © 2019 Zup. All rights reserved.
//

import UIKit

class GithubersViewController: UIViewController, GithubersPresenterDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    lazy var presenter = GithubersPresenter(delegate: self)
    var githubers: Githubers = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        registerCell()
        presenter.fetchAllGithubers()
    }
    
    func displayGithubers(result: Result<Githubers>) {
        switch result {
        case .success(let githubers):
            self.githubers = githubers
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case.failure(let err):
            print(err.code)
        }
    }
}

extension GithubersViewController {

    private func registerCell() {
        let githubersCellNib = UINib(nibName: GithuberCollectionViewCell.cellIdentifier, bundle: nil)
        collectionView.register(githubersCellNib, forCellWithReuseIdentifier: GithuberCollectionViewCell.cellIdentifier)
    }
}

extension GithubersViewController {

    private func setupStyle() {
        collectionView.backgroundColor = .clear
    }
}

extension GithubersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return githubers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GithuberCollectionViewCell.cellIdentifier, for: indexPath)
        let githuber = githubers[indexPath.item]
        guard let githubersCell = cell as? GithuberCollectionViewCell else {
            return UICollectionViewCell()
        }
        githubersCell.fill(githuber)
        return githubersCell
    }
}

extension GithubersViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32.0, height: 80)
    }
}
