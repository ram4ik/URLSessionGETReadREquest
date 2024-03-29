//
//  ContentView.swift
//  URLSessionGETReadREquest
//
//  Created by Ramill Ibragimov on 01.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                Music.fetch(1) { (nm) in
                    print(nm.music_url ?? "no url")
                    if let md = try? JSONEncoder().encode(nm) {
                        print(md)
                    }
                }
            }) {
                Text("Fetch data")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
