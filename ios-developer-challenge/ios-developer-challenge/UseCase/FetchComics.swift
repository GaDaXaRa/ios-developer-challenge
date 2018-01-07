//
//  FetchComics.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class FetchComics: NSObject, FetchComicsUseCase {
    let fetchComicsTask: FetchComicsTask
    
    init(fetchComicsTask: FetchComicsTask = FetchComicsTask()) {
        self.fetchComicsTask = fetchComicsTask
    }

    func fetch(offset: Int, numComics: Int, completion: @escaping (_: [Comic]?) -> ()) {
        DispatchQueue.global().async {
            self.fetchComicsTask.fetchComics(offset: offset, numComics: numComics, completion: { (json) in
                guard let json = json, let data = json["data"] as? [String: Any], let results = data["results"] as? [[String: Any]] else {
                    completion(nil)
                    return
                }
                let comics = results.flatMap({return Comic(json: $0)})
                completion(comics)
            })
        }
    }
}
