//
//  NetworkProvider.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import Foundation

final class NetworkProvider {
    
    static let shared = NetworkProvider()
    
    private let kBaseURL = ConfigValues.get().MovieListURL
    private let kToken = ConfigValues.get().TokenDB
    private let kMovieDetails = ConfigValues.get().MovieDetailsURL
    
    
    func showMoviesList(success: @escaping (_ page: pageResponse)->(), failure: @escaping (_ error: Error?)->()) {
        let URLDB = "\(kBaseURL)\(kToken)"
        let URL = URL(string: URLDB)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: URL!) { data, response, error in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let page = try decoder.decode(pageResponse.self, from: data!)
                    DispatchQueue.main.async {
                        success(page)
                    }
                }catch{
                    print("Error in parsing JSON")
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func movieDetails(id: Int, success: @escaping (_ movie: firstResponse) -> (), failure: @escaping (_ error: Error?)->()){
        let URLMovie = "\(kMovieDetails)\(id)?api_key=\(kToken)"
        let URL = URL(string: URLMovie)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: URL!) { data, response, error in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    let movie = try decoder.decode(firstResponse.self, from: data!)
                    DispatchQueue.main.async {
                        success(movie)
                    }
                }catch{
                    print("Error in Parsing JSON")
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
