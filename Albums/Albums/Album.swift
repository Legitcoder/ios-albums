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
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        
        var artUrls: [URL] = []
        while !coverArtContainer.isAtEnd {
            let urlContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKeys.self)
            let url = try urlContainer.decode(String.self, forKey: .url)
            if let urlObject = URL(string: url) {
                artUrls.append(urlObject)
            }
        }
        
        self.coverArt = artUrls
        self.artist = artist
    }
    
    
    var artist: String
    var coverArt: [URL]
}
