//
//  Movie.swift
//  Movies Time
//
//  Created by Jose Enrique Montañez Villanueva on 05/09/21.
//

import Foundation

struct Movie: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterImageString = "poster_path"
        case voteAverage = "vote_average"
        
    }
    
    let id: Int
    let title: String
    let overview: String
    let posterImageString: String
    let releaseDate: String
    let voteAverage: Float
}
