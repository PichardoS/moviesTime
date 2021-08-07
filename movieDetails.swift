//
//  movieDetails.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import UIKit
import Kingfisher

class movieDetails: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var myLanguageLabel: UILabel!
    @IBOutlet weak var myGendreLabel: UILabel!
    @IBOutlet weak var myReviewLabel: UILabel!
    @IBOutlet weak var myPercentageLabel: UILabel!
    @IBOutlet weak var myStatusLabel: UILabel!
    @IBOutlet weak var myBudgetLabel: UILabel!
    @IBOutlet weak var myRevenueLabel: UILabel!
    
    var  id = 0
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Entro a la segunda pantalla con: \(id)")
        var genres = " ", temp = " "
        let imageURL = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2"
        
        NetworkProvider.shared.movieDetails(id: id) { movie in
            self.myTitleLabel.text = movie.original_title
            self.myDateLabel.text = movie.release_date
            self.myLanguageLabel.text = movie.original_language
            self.myStatusLabel.text = movie.status
            self.myBudgetLabel.text = "$ "+String(movie.budget)
            self.myRevenueLabel.text = "$ "+String(movie.revenue)
            self.myReviewLabel.text = movie.overview
            self.myPercentageLabel.text = String(Int(movie.vote_average*10))+" %"
            let count = movie.genres.count
            let gen = movie.genres
            
            if movie.genres.count > 1{
                for num in 0 ..< count{
                    temp = gen[num].name
                    genres = genres + temp + ", "
                }
            }else{
                genres = gen[0].name
            }
            self.myGendreLabel.text = genres
            self.myImage.kf.setImage(with: URL(string: "\(imageURL)\(movie.poster_path ?? "")"))
        } failure: { error in
            
        }
    }
}
