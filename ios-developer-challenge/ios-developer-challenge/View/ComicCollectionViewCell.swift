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
    var title: String {get}
}

class ComicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with viewModel: ComicCellViewModel) {
        DispatchQueue.main.async {
            self.comicImage.imageFrom(url: viewModel.imageUrl)
            self.titleLabel.text = viewModel.title
        }
    }
    
    override func prepareForReuse() {
        comicImage.image = nil
    }
}
