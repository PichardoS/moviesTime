//
//  MovieDetails.swift
//  Movies Time
//
//  Created by Jose Eduardo on 07/09/21.
//

import Foundation

struct MovieDetails: Decodable {
    
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

