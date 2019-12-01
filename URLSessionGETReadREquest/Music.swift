//
//  Music.swift
//  URLSessionGETReadREquest
//
//  Created by Ramill Ibragimov on 01.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import Foundation

let myUrl = "https://www.orangevalleycaa.org/api/"

class Music: Codable {
    
    var guid: String?
    var music_url: String?
    var name: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case guid = "id"
        case music_url, name, description
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let serverGUID = guid?.replacingOccurrences(of: "id", with: "")
        try container.encode(serverGUID, forKey: .guid)
        try container.encode(name, forKey: .name)
        // and the rest properties
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let val = try values.decode(String.self, forKey: .guid)
        guid = "id:\(val)"
        name = try values.decode(String.self, forKey: .name)
        // rest of properties
    }
    
    static func fetch(_ id: Int, completionHandler: @escaping (Music) -> Void) {
        let urlString = myUrl + "music/id/\(id)"
        
        if let url = URL.init(string: urlString) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                print(String.init(data: data!, encoding: .ascii) ?? "No data.")
                
//                if let objData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
//                    if let dict = objData as? [String: Any] {
//                        let nm = Music()
//                        nm.id = dict["id"] as? String
//                        nm.name = dict["name"] as? String
//                        nm.description = dict["description"] as? String
//                        nm.music_url = dict["music_url"] as? String
//                    }
//                }
                if let nm = try? JSONDecoder().decode(Music.self, from: data!) {
                    print(nm.music_url ?? "no url")
                    print(nm.guid ?? "no id")
                    completionHandler(nm)
                }
            })
            task.resume()
        }
    }
    
    static func fetchAll(completionHandler: @escaping ([Music]) -> Void) {
        let urlString = myUrl + "music/"
        
        if let url = URL.init(string: urlString) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                print(String.init(data: data!, encoding: .ascii) ?? "No data.")
                if let nm = try? JSONDecoder().decode([Music].self, from: data!) {
                    completionHandler(nm)
                }
            })
            task.resume()
        }
    }
    
    func saveToServer() {
        let urlString = myUrl + "music/"
        
        var req = URLRequest.init(url: URL.init(string: urlString)!)
        req.httpMethod = "POST"
        req.httpBody = try? JSONEncoder().encode(self)
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            print(String.init(data: data!, encoding: .ascii) ?? "no data")
        }
        task.resume()
    }
    
    func updateServer() {
        guard self.guid != nil else { return }
        let urlString = myUrl + "music/id/\(self.guid!)"
        
        var req = URLRequest.init(url: URL.init(string: urlString)!)
        req.httpMethod = "PUT"
        req.httpBody = try? JSONEncoder().encode(self)
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            print(String.init(data: data!, encoding: .ascii) ?? "no data")
        }
        task.resume()
    }
    
    func deleteFromServer() {
        guard self.guid != nil else { return }
        let urlString = myUrl + "music/id/\(self.guid!)"
        
        var req = URLRequest.init(url: URL.init(string: urlString)!)
        req.httpMethod = "DELETE"
        req.httpBody = try? JSONEncoder().encode(self)
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            print(String.init(data: data!, encoding: .ascii) ?? "no data")
        }
        task.resume()
    }
}
