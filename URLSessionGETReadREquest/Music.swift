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
    
    static func fetch(_ id: Int) {
        let urlString = myUrl + "music/id/\(id)"
        
        if let url = URL.init(string: urlString) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                print(String.init(data: data!, encoding: .ascii) ?? "No data.")
            })
            task.resume()
        }
    }
}
