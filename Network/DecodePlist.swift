//
//  DecodePlist.swift
//  moviesTime
//
//  Created by Jose Eduardo on 23/08/21.
//

import UIKit

struct MoviesDB: Decodable {
    let MovieListURL: String
    let MovieDetailsURL: String
    let TokenDB: String
    let ImageURL: String
}

struct ConfigValues {
    static func get() -> MoviesDB {
        guard let url = Bundle.main.url(forResource: "MoviesDB", withExtension: "plist") else {
            fatalError("Could not find MoviesDB.plist in your Bundle")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(MoviesDB.self, from: data)
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
}
