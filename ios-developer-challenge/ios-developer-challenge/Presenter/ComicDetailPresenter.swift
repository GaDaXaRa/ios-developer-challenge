//
//  ComicDetailPresenter.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol ComicDetailView: class {
    func configure(with viewModel: ComicDetailViewModel)
}

class ComicDetailPresenter: NSObject {
    
    weak var view: ComicDetailView? {
        didSet {
            view?.configure(with: comic)
        }
    }

    let comic: Comic!
    
    init(comic: Comic) {
        self.comic = comic
    }
}

extension Comic: ComicDetailViewModel {
    
}
