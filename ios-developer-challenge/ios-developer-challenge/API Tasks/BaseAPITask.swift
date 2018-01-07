//
//  BaseAPITask.swift
//  ios-developer-challenge
//
//  Created by Miguel Santiago Rodríguez on 7/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class BaseAPITask: NSObject {
    private static let baseURL = URL(string: "http://gateway.marvel.com/v1/public/")!
    private static let publicKey = "3424f0c290722b12ed2ded28b19ae8c1"
    private static let privateKey = "f975fba35917f080bda1ba66c5fddbf1467c1070"
    
    
    var payload = [String: String]()

    func sendRequest(path: String = "", completion: @escaping (_: [String: Any]?) -> ()) {
        let timeStamp = "\(Int(Date().timeIntervalSince1970))"
        payload["apikey"] = BaseAPITask.publicKey
        payload["ts"] = timeStamp
        payload["hash"] = "\(timeStamp)\(BaseAPITask.privateKey)\(BaseAPITask.publicKey)".md5
        guard let url = compose(path: path, with: payload) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion(nil)
                return
            }
            
            completion(json)
        }.resume()
    }
    
    private func compose(path: String, with params: [String: String]) -> URL? {
        let url = BaseAPITask.baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = params.map {URLQueryItem(name: $0.key, value: $0.value)}
        return components?.url
    }
}
