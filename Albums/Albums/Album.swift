//
//  Album.swift
//  Albums
//
//  Created by Moin Uddin on 10/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


struct Album: Decodable {
    enum AlbumCodingKeys: String, CodingKey {
        case artist
        case coverArt
        
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
        
        case genres
        case id
        case name
        case songs
        
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        let artist = try container.decode(String.self, forKey: .artist)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genres: [String] = []
        while !genreContainer.isAtEnd {
            let genre = try genreContainer.decode(String.self)
            genres.append(genre)
            
        }
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        
        var artUrls: [URL] = []
        while !coverArtContainer.isAtEnd {
            let urlContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKeys.self)
            let url = try urlContainer.decode(String.self, forKey: .url)
            if let urlObject = URL(string: url) {
                artUrls.append(urlObject)
            }
        }
        
        var songContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songs: [Song] = []
        
        while !songContainer.isAtEnd {
            let song = try songContainer.decode(Song.self)
            songs.append(song)
        }
        
        
        self.id = id
        self.name = name
        self.coverArt = artUrls
        self.artist = artist
        self.genres = genres
        self.songs = songs
    }
    
    
    var id: String
    var name: String
    var artist: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Song]
}
