//
//  Music.swift
//  URLSessionGETReadREquest
//
//  Created by Ramill Ibragimov on 01.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import Foundation

let myUrl = "https://www.orangevalleycaa.org/api/"

class Music {
    
    var id: String?
    var music_url: String?
    var name: String?
    var description: String?
    
    static func fetch(_ id: Int) {
        let urlString = myUrl + "music/id/\(id)"
        
        if let url = URL.init(string: urlString) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                print(String.init(data: data!, encoding: .ascii) ?? "No data.")
                
                if let objData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
                    if let dict = objData as? [String: Any] {
                        let nm = Music()
                        nm.id = dict["id"] as? String
                        nm.name = dict["name"] as? String
                        nm.description = dict["description"] as? String
                        nm.music_url = dict["music_url"] as? String
                    }
                }
            })
            task.resume()
        }
    }
}
