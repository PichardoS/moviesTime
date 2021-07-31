//
//  ViewController.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.register(UINib(nibName: "myTableViewCell", bundle: nil), forCellReuseIdentifier: "my Table View Cell")
        
    }


}

