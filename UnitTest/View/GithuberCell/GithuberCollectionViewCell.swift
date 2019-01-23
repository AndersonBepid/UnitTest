//
//  UserCollectionViewCell.swift
//  Gitz
//
//  Created by Anderson Moura de Oliveira on 28/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import UIKit

class GithuberCollectionViewCell: UICollectionViewCell {
    
    // MARK IBOutlets

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: Static Properties

    static let cellIdentifier = "\(GithuberCollectionViewCell.self)"

    // MARK: Properties

    override func draw(_ rect: CGRect) {
        setupStyle()
    }
}

extension GithuberCollectionViewCell {

    func fill(_ sender: Githuber) {
        profileImageView.loadImageUsingCache(withUrlString: sender.photo, defaultImage: #imageLiteral(resourceName: "github"), loadingActivityIndicatorStyle: .white)
        nameLabel.text = sender.name
        typeLabel.text = sender.type
    }
}

// MARK: Setup Style

extension GithuberCollectionViewCell {

    private func setupStyle() {
        dropShadow()
        containerView.layer.cornerRadius = 8.0
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.0
        profileImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)
        profileImageView.layer.borderWidth = 1.0
    }
}
