//
//  AlbumController.swift
//  Albums
//
//  Created by Moin Uddin on 10/9/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


class AlbumController {
    
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("JSON file doesn't exist")
            return
        }
        
        do {
            //Mimicking getting JSON from API
            let albumData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: albumData)
            
            print("Success")
        } catch {
            NSLog("Error decoding Album: \(error)")
        }
    }
}
