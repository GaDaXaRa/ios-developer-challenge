//
//  ComicDetailViewController.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol ComicDetailViewModel {
    var imageUrl: URL? {get}
    var title: String {get}
    var description: String? {get}
}

class ComicDetailViewController: UIViewController {

    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var presenter: ComicDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsetsMake(UIScreen.main.bounds.height / 2, 0, 0, 0)
        presenter.view = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

extension ComicDetailViewController: ComicDetailView {
    
    func configure(with viewModel: ComicDetailViewModel) {
        DispatchQueue.main.async {
            self.comicImage.imageFrom(url: viewModel.imageUrl)
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.description
        }
    }
}
