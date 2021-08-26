//
//  DetailsMovie.swift
//  moviesTime
//
//  Created by Jose Eduardo on 31/07/21.
//


import Foundation

struct firstResponse: Decodable {
    let adult: Bool
    let backdrop_path: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdb_id: String?
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Float
    let poster_path: String?
    let release_date: String
    let revenue: Int
    let runtime: Int
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int

}

struct Genre: Decodable {
    let id: Int
    let name: String
}
