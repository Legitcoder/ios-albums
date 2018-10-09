//
//  Song.swift
//  Albums
//
//  Created by Moin Uddin on 10/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation

struct Song: Codable, Equatable {
    
    init(id: String = UUID().uuidString, name: String, duration: String) {
        self.id = id
        self.name = name
        self.duration = duration
    }
    
    enum SongCodingKeys: String, CodingKey, Equatable {
        case id
        case name
        case duration
        
        enum NameCodingKeys: String, CodingKey, Equatable {
            case title
        }
        
        enum DurationCodingKeys: String, CodingKey, Equatable {
            case duration
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongCodingKeys.self)
        try container.encode(id, forKey: .id)
        
        var nameContainer = container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
        var durationContainer = container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        try durationContainer.encode(duration, forKey: .duration)
    }
    
    
    init(from decoder: Decoder) throws {
        
        //Decode
        //Break down containers. Containers are Javascript Objects
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.NameCodingKeys.self, forKey: .name)
        
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        //Set Properties
        self.id = id
        self.name = name
        self.duration = duration
        
    }
    
    //Initialize Properties in Struct
    var id: String
    var name: String
    var duration: String

    
}
