//
//  MoviesList.swift
//  Movies Time
//
//  Created by Jose Enrique Montañez Villanueva on 05/09/21.
//

import Foundation


struct MoviesList: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
    let movies: [Movie]
    
}
