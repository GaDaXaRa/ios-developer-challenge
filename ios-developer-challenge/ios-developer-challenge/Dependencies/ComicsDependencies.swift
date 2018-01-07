//
//  ComicsDependencies.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class ComicsDependencies: NSObject {

    static private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static private let comicDetailStoryboard = UIStoryboard(name: "ComicDetail", bundle: nil)
    
    static func comicsListViewController(wireframe: ComicsListWireframe) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "comicsList") as! ViewController
        let presenter = ComicListPresenter(wireframe: wireframe)
        viewController.presenter = presenter
        return viewController
    }
    
    static func comicDetailViewController(comic: Comic) -> UIViewController {
        let viewController = comicDetailStoryboard.instantiateViewController(withIdentifier: "ComicDetail") as! ComicDetailViewController
        let presenter = ComicDetailPresenter(comic: comic)
        viewController.presenter = presenter
        return viewController
    }
}
