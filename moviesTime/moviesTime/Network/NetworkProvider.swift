//
//  NetworkProvider.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import Foundation
import Alamofire

final class NetworkProvider{
    
    static let shared = NetworkProvider()
    
    private let kBaseURL = "https://api.themoviedb.org/3/movie/"
    private let kStatusOK = 200...299
    private let kToken = "fba6ca5936c13c699f9bb839eeb4de35"
    
    func showMovies(success: @escaping ()->(), failure: @escaping (_ error: Error?)->()) {
        let URL = "\(kBaseURL)popular?api_key=\(kToken)"
        AF.request(URL, method: .get).validate(statusCode: kStatusOK)
        
    }
}
