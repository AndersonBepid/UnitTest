//
//  UIImageView+Download.swift
//  Gitz
//
//  Created by Anderson Oliveira on 28/10/18.
//  Copyright (c) 2018 Anderson Oliveira. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCache(withUrlString: String, defaultImage: UIImage, loadingActivityIndicatorStyle: UIActivityIndicatorView.Style) {
        
        DispatchQueue.main.async {
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
            self.image = defaultImage
            let viewTransparente = UIView()
            
            viewTransparente.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
            viewTransparente.frame.origin = CGPoint(x: 0, y: 0)
            viewTransparente.backgroundColor = .black
            viewTransparente.alpha = 0.6
            
            let loadingActivityIndicator = UIActivityIndicatorView(style: loadingActivityIndicatorStyle)

            loadingActivityIndicator.startAnimating()
            loadingActivityIndicator.center = viewTransparente.center
            viewTransparente.addSubview(loadingActivityIndicator)
            super.addSubview(viewTransparente)

            if let cacheImage = imageCache.object(forKey: withUrlString as NSString) {
                self.image = cacheImage
                viewTransparente.removeFromSuperview()
                return
            }

            guard let url = URL(string: withUrlString) else {
                viewTransparente.removeFromSuperview()
                return
            }

            URLSession.shared.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    DispatchQueue.main.async {
                        viewTransparente.removeFromSuperview()
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let d = data, let imagem = UIImage(data: d) {
                        imageCache.setObject(imagem, forKey: withUrlString as NSString)
                        self.image = imagem
                        viewTransparente.removeFromSuperview()
                    }
                }
            }).resume()
        }
    }
    
    func addBlur(_ blur: UIVisualEffectView){
        let blurEffect = UIBlurEffect(style: .light)
        let loadingActivityIndicator = UIActivityIndicatorView(style: .gray)

        blur.frame = self.frame
        blur.frame.origin = CGPoint(x: 0, y: 0)
        loadingActivityIndicator.color = .black
        loadingActivityIndicator.startAnimating()
        loadingActivityIndicator.center = blur.center
        blur.addSubview(loadingActivityIndicator)
        blur.effect = blurEffect
    }
}

extension UIImage {
    
    class func loadImage(withUrl url: String, completion: @escaping (_ image: UIImage?) -> Void) -> () {
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                completion(nil)
                return
            }
            if let d = data, let imagem = UIImage(data: d) {
                completion(imagem)
            }
        }).resume()
    }
    
}
