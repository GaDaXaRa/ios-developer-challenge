//
//  Comic.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

struct Comic {
    let id: String
    let title: String
    let description: String?
    let imageUrl: URL?
    
    init?(json: [String: Any]?) {
        guard
            let json = json,
            let id = json["id"] as? Int,
            let title = json["title"] as? String
        else {
            return nil
        }
        
        self.id = "\(id)"
        self.title = title
        self.description = json["description"] as? String
        
        if let thumbnail = json["thumbnail"] as? [String: Any], let path = thumbnail["path"] as? String, let imageExtension = thumbnail["extension"], let imageUrl = URL(string: "\(path).\(imageExtension)") {
            self.imageUrl = imageUrl
        } else {
            self.imageUrl = nil
        }
    }
}
