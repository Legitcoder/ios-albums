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
        
        func createAlbum(name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
            let album = Album(name: name, artist: artist, genres: genres, coverArt: coverArt, songs: songs)
            albums.append(album)
            put(album: album)
        }
        
        func update(album: Album, name: String, artist: String, genres: [String], coverArt: [URL], songs: [Song]) {
            guard let index = albums.index(of: album) else { return }
            var currentAlbum = albums[index]
            currentAlbum.name = name
            currentAlbum.artist = artist
            currentAlbum.coverArt = coverArt
            currentAlbum.genres = genres
            currentAlbum.songs = songs
            put(album: currentAlbum)
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
    
    
    func getAlbums(completion: @escaping (Error?) -> Void  = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error getting albums: \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            
            do {
                let albumsObject = try JSONDecoder().decode([String: Album].self, from: data)
                self.albums = albumsObject.map({ $0.value })
            } catch {
                NSLog("Error decoding albums \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    func put(album: Album) {
        let requestURl = baseURL.appendingPathExtension(String(album.id)).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURl)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(album)
        } catch {
            NSLog("Error encoding album and putting it to firebase: \(album)")
        }
    }
    
    
    
    var baseURL = URL(string: "https://intermediatecodable.firebaseio.com/")!
    var albums: [Album] = []
    
}
