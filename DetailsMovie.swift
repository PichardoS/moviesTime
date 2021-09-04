//
//  DetailsMovie.swift
//  moviesTime
//
//  Created by Jose Eduardo on 31/07/21.
//

/*
    "adult":false,
    "backdrop_path":"/rr7E0NoGKxvbkb89eR1GwfoYjpA.jpg",
    "belongs_to_collection":null,
    "budget":63000000,
    "genres":[
       {
          "id":18,
          "name":"Drama"
       }
    ],
    "homepage":"http://www.foxmovies.com/movies/fight-club",
    "id":550,
    "imdb_id":"tt0137523",
    "original_language":"en",
    "original_title":"Fight Club",
    "overview":"A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
    "popularity":46.449,
    "poster_path":"/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
    "production_companies":[...],
    "production_countries":[...],
    "release_date":"1999-10-15",
    "revenue":100853753,
    "runtime":139,
    "spoken_languages":[
       {
          "english_name":"English",
          "iso_639_1":"en",
          "name":"English"
       }
    ],
    "status":"Released",
    "tagline":"Mischief. Mayhem. Soap.",
    "title":"Fight Club",
    "video":false,
    "vote_average":8.4,
    "vote_count":22110,
    "images":{
       "backdrops":[...],
       "logos":[...],
       "posters":[...]
    }
 */

import Foundation

struct firstResponse: Decodable {
    let adult: Bool
    let backdrop_path: String?
    //let belongs_to_collection: Colection?
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
    //let production_companies: Production
    //let production_countries: Production
    let release_date: String
    let revenue: Int
    let runtime: Int
    //let spoken_languages: Language
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int
    //let images: Image

}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct Language: Decodable {
    let english_name: String
    let iso_639_1: String
    let name: String
}

struct Production: Decodable {
    
}

struct Image: Decodable {
    
}

struct Colection: Decodable {
    
}
