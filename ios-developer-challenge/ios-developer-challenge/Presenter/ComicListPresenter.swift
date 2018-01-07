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
    func insertComics(at indexPaths: [IndexPath], completion: @escaping () -> ())
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
    private var isLoading = false
    
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
    
    func willDisplayComic(at indexPath: IndexPath) {
        guard let comics = comics else {return}
        if indexPath.row == comics.count - 1 {
            fetchNextComics()
        }
    }
    
    func didSelectComic(at indexPath: IndexPath) {
        guard let comics = comics else {return}
        wireframe?.openComicDetail(comics[indexPath.row])
    }
    
    private func fetchNextComics() {
        guard isLoading == false else {return}
        isLoading = true
        fetchComicsUseCase.fetch(offset: numComics, numComics: ComicListPresenter.comicsPerPage) { [weak self] (newComics) in
            guard let newComics = newComics, newComics.count > 0, let strongSelf = self else {return}
            let newIndexPaths = strongSelf.indexPathsForNewComics(newComics)
            if strongSelf.comics != nil {
                strongSelf.comics!.append(contentsOf: newComics)
            } else {
                strongSelf.comics = newComics
            }
            
            strongSelf.view?.insertComics(at: newIndexPaths, completion: {
                strongSelf.isLoading = false
            })
        }
    }
    
    private func indexPathsForNewComics(_ newComics: [Comic]) -> [IndexPath] {
        let comicsCount = comics?.count ?? 0
        var indexPaths = [IndexPath]()
        for index in comicsCount...comicsCount + newComics.count - 1 {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        
        return indexPaths
    }
}

extension Comic: ComicCellViewModel {
    
}
