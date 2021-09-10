//
//  NetworkProvider.swift
//  Movies Time
//
//  Created by Jose Enrique Montañez Villanueva on 05/09/21.
//

import UIKit

final class NetworkProvider {
    
    static let shared = NetworkProvider()
    
    enum NetworkError: Error {
        case jsonParsing
        case requestError
        case missingSettings
        case responseError
    }
    
    enum RequestType {
        case moviesList
        case movieDetails
    }
    
    var preferences: [String: Any]? {
        guard let preferencesPath = Bundle.main.path(forResource: "Preferences", ofType: "plist"),
              let preferencesDict = NSDictionary(contentsOfFile: preferencesPath) as? [String: Any] else { return nil }
           return preferencesDict
    }
    
    var baseURL: String? {
        guard let baseURL = preferences?["baseURL"] as? String else { return nil}
        return baseURL
    }
    
    var token: String? {
        guard let token = preferences?["apiKey"] as? String else { return nil }
        return token
    }
    
    var baseImageURL: String? {
        guard let baseURL = preferences?["baseImageURL"] as? String else { return nil}
        return baseURL
    }
    
    private let moviesPath: String = "movie/top_rated"
    
    private init() {}
    
    
    func fetchMovies(completion: @escaping (Result<MoviesList, NetworkError>)-> Void) {
        
        guard let url = urlFor(requestType: .moviesList) else {
            completion(.failure(.missingSettings))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.responseError))
                return
            }
            
            do {
                let movieList = try JSONDecoder().decode(MoviesList.self, from: data)
                completion(.success(movieList))
            } catch let error {
                print(error)
                completion(.failure(.jsonParsing))
            }
        }.resume()
    }
    
    func fetchMoviesDetails(id: Int, completion: @escaping (Result<MovieDetails, NetworkError>)-> Void) {
        guard let url = urlFor(requestType: .movieDetails, id) else {
            completion(.failure(.missingSettings))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.responseError))
                return
            }
            
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(.success(movieDetail))
            } catch let error {
                print(error)
                completion(.failure(.jsonParsing))
            }
        }.resume()
    }
    
    func retrieveImageFor(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        guard let baseImageURL = baseImageURL,
              let imageURL = URL(string: "\(baseImageURL)\(imagePath)") else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
    private func urlFor(requestType: RequestType, _ id: Int=0) -> URL? {
        let queryParams = queryParamsFor(requestType: requestType)
        
        guard var urlString = baseURL,
              !queryParams.isEmpty else {
            return nil
        }
        
        switch requestType {
        case .moviesList:
            urlString.append(moviesPath)
        case .movieDetails:
            urlString.append("movie/\(id)")
        }
        var query = "?"
        for (key, value) in queryParams {
            query.append("\(key)=\(value)&")
        }
        query.removeLast()
        urlString.append(query)
        
        return URL(string: urlString)
    }
    
    private func queryParamsFor(requestType: RequestType) -> [String: String] {
        var queryParams = [String: String]()
        
        switch requestType {
        case .movieDetails:
            queryParams["api_key"] = token
            queryParams["language"] = "es-MX"
        case .moviesList:
            queryParams["api_key"] = token
            queryParams["language"] = "es-MX"
            queryParams["page"] = "1"
            queryParams["region"] = "MX"
        }
        return queryParams
    }
}
