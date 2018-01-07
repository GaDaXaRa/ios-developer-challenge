//
//  FetchComicsTask.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class FetchComicsTask: BaseAPITask {

    func fetchComics(offset: Int, numComics: Int, completion: @escaping (_: [String: Any]?) -> ()) {
        payload["format"] = "magazine"
        payload["formatType"] = "comic"
        payload["orderBy"] = "-onsaleDate"
        payload["noVariants"] = "true"
        payload["limit"] = "\(numComics)"
        payload["offset"] = "\(offset)"
        sendRequest(path: "comics", completion: completion)
    }
}
