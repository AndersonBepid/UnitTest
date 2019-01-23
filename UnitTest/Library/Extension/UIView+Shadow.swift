//
//  UIView+Shadow.swift
//  Lerosa
//
//  Created by Anderson Oliveira on 28/10/18.
//  Copyright (c) 2018 Anderson Oliveira. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor = .black, opacity: Float = 1, offSet: CGSize = CGSize(width: 0, height: 0), radius: CGFloat = 8.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}
