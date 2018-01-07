//
//  ComicListPresenter.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol ComicListView: class {
    func reload()
}

protocol FetchComicsUseCase {
    func fetch(offset: Int, numComics: Int, completion: @escaping (_: [Comic]?) -> ())
}

protocol ComicsListWireframe {
    func openComicDetail(_: Comic)
}

class ComicListPresenter: NSObject {
    private static var comicsPerPage = 20

    weak var view: ComicListView? {
        didSet {
            fetchNextComics()
        }
    }
    
    private let wireframe: ComicsListWireframe?
    private var comics: [Comic]?
    
    private let fetchComicsUseCase: FetchComicsUseCase
    
    init(fetchComicsUseCase: FetchComicsUseCase = FetchComics(), wireframe: ComicsListWireframe?) {
        self.fetchComicsUseCase = fetchComicsUseCase
        self.wireframe = wireframe
    }
    
    var numComics: Int {
        guard let comics = comics else {return 0}
        return comics.count
    }
    
    func comicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel {
        guard let comics = comics else {fatalError("Trying to access comic before comics are loaded")}
        return comics[indexPath.row]
    }
    
    func didSelectComic(at indexPath: IndexPath) {
        guard let comics = comics else {return}
        wireframe?.openComicDetail(comics[indexPath.row])
    }
    
    private func fetchNextComics() {
        fetchComicsUseCase.fetch(offset: numComics, numComics: ComicListPresenter.comicsPerPage) { [weak self] (newComics) in
            guard let newComics = newComics else {return}
            if self?.comics != nil {
                self?.comics!.append(contentsOf: newComics)
            } else {
                self?.comics = newComics
            }
            self?.view?.reload()
        }
    }
}

extension Comic: ComicCellViewModel {
    
}
