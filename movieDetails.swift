//
//  movieDetails.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkProvider.shared.movieDetails(id: 337404) { movie in
            self.myTitleLabel.text = movie.original_title
            self.myDateLabel.text = movie.release_date
            self.myLanguageLabel.text = movie.original_language
            self.myStatusLabel.text = movie.status
            self.myBudgetLabel.text = "$ "+String(movie.budget)
            self.myRevenueLabel.text = "$ "+String(movie.revenue)
            self.myReviewLabel.text = movie.overview
            self.myPercentageLabel.text = String(movie.vote_average*10)+" %"
        } failure: { error in
            
        }

/*         "Title"
        "Date"
         "Language"
        myGendreLabel.text = "Genre"
         "Status"
        "$ Budget"
         "$ Revenue"
         "Review"
         " % "
*/
    }
    
}
