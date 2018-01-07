//
//  UIImageView.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageFrom(url: URL?) {
        guard let url = url else {return}
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data, response, error) in
            guard
                error == nil,
                let data = data,
                let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
