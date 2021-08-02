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
        myTitleLabel.text = "Title"
        myDateLabel.text = "Date"
        myLanguageLabel.text = "Language"
        myGendreLabel.text = "Genre"
        myStatusLabel.text = "Status"
        myBudgetLabel.text = "$ Budget"
        myRevenueLabel.text = "$ Revenue"
        myReviewLabel.text = "Review"
        myPercentageLabel.text = " % "
        
    }
    
}