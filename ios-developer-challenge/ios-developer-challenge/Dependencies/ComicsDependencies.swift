//
//  ComicsDependencies.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class ComicsDependencies: NSObject {

    static private let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    static func comicsListViewController() -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "comicsList") as! ViewController
        let presenter = ComicListPresenter()
        viewController.presenter = presenter
        return viewController
    }
}
