//
//  ComicsWireframe.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class ComicsWireframe: NSObject {
    private(set) var rootViewController: UINavigationController!
    
    override init() {
        super.init()
        rootViewController = UINavigationController(rootViewController: ComicsDependencies.comicsListViewController(wireframe: self))
    }    
}

extension ComicsWireframe: ComicsListWireframe {
    func openComicDetail(_ comic: Comic) {
        rootViewController.pushViewController(ComicsDependencies.comicDetailViewController(comic: comic), animated: true)
    }   
}
