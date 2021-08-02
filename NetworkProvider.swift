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
    let details = moviesTime.movieDetails()
    
    private let kBaseURL = "https://api.themoviedb.org/3/movie/"
    private let kStatusOK = 200...299
    private let kToken = "fba6ca5936c13c699f9bb839eeb4de35"
    
    func showMovies(/*success: @escaping (_ page: pageResponse)->(), failure: @escaping (_ error: Error?)->()*/) {
        let URL = "\(kBaseURL)popular?api_key=\(kToken)"
        AF.request(URL, method: .get).validate(statusCode: kStatusOK).responseDecodable (of: pageResponse.self){ response in
            
            if let page = response.value{
                print(page.page)
                print(page.total_pages)
                print(page.total_results)
            }else {
                print(response.error?.errorDescription ?? "No error")
            }
        }
        
    }
    
    func movieDetails(id: Int){
        let URL = "\(kBaseURL)\(id)?api_key=\(kToken)"
        AF.request(URL, method: .get).validate(statusCode: kStatusOK).responseDecodable (of: firstResponse.self){ response in
            if let movie = response.value{
                print(movie.original_title)
/*                self.details.myTitleLabel.text = movie.original_title
                self.details.myDateLabel.text = movie.release_date
                self.details.myLanguageLabel.text = movie.original_language
                self.details.myReviewLabel.text = movie.overview
                self.details.myPercentageLabel.text = String(movie.vote_average*10)+"%"
                self.details.myStatusLabel.text = movie.status
                self.details.myBudgetLabel.text = "$"+String(movie.budget)
                self.details.myRevenueLabel.text = "$"+String(movie.revenue)
*/            }else{
                print(response.error?.errorDescription ?? "No error")
            }
        }
    }
}
