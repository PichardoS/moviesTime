//
//  Movies.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

/*
 Example:
 "page":1,
    "results":[
       {
          "adult":false,
          "backdrop_path":"/8s4h9friP6Ci3adRGahHARVd76E.jpg",
          "genre_ids":[
             16,
             35,
             10751,
             878
          ],
          "id":379686,
          "original_language":"en",
          "original_title":"Space Jam: A New Legacy",
          "overview":"When LeBron and his young son Dom are trapped in a digital space by a rogue A.I. ...",
          "popularity":4464.745,
          "poster_path":"/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
          "release_date":"2021-07-08",
          "title":"Space Jam: A New Legacy",
          "video":false,
          "vote_average":7.7,
          "vote_count":1338
       },
 "total_pages":500,
 "total_results":10000
 */

import Foundation

struct pageResponse: Decodable{
    let page: Int
    let results: [Results]
    let total_pages: Int
    let total_results: Int
}

struct Results: Decodable{
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Float
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int
}
