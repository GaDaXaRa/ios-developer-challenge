//
//  ComicCollectionViewCell.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol ComicCellViewModel {
    var imageUrl: URL? {get}
}

class ComicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var comicImage: UIImageView!
    
    func configure(with viewModel: ComicCellViewModel) {
        DispatchQueue.main.async {
            self.comicImage.imageFrom(url: viewModel.imageUrl)
        }
    }
    
    override func prepareForReuse() {
        comicImage.image = nil
    }
}
