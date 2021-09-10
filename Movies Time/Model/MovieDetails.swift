//
//  MovieDetails.swift
//  Movies Time
//
//  Created by Jose Eduardo on 07/09/21.
//

import Foundation

struct MovieDetails: Decodable {
    
/*    private enum CodingKeys: String, CodingKey {
        case budget, genres, id, overview, revenue
        case releaseDate = "release_date"
        case posterImageString = "poster_path"
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
    }
*/
    let budget: Int
    let genres: [Genre]
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let release_date: String
    let revenue: Int
    let vote_average: Float
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

