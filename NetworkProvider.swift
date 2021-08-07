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
    private let kImageURL = "&include_image_language=null"
    
    
    func showMovies(success: @escaping (_ page: pageResponse)->(), failure: @escaping (_ error: Error?)->()) {
        let URL = "\(kBaseURL)popular?api_key=\(kToken)"
        AF.request(URL, method: .get).validate(statusCode: kStatusOK).responseDecodable (of: pageResponse.self){ response in
            
            if let page = response.value{
                success(page)

            }else {
                failure(response.error)
            }
        }
        
    }
    
    func movieDetails(id: Int, success: @escaping (_ movie: firstResponse) -> (), failure: @escaping (_ error: Error?)->()){
        let URL = "\(kBaseURL)\(id)?api_key=\(kToken)"
        AF.request(URL, method: .get).validate(statusCode: kStatusOK).responseDecodable (of: firstResponse.self){ response in
            if let movie = response.value{
                success(movie)

            }else{
                failure(response.error)
            }
        }
    }
}
