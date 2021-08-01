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
        
        myTableView.tableFooterView = UIView()
        myTableView.register(UINib(nibName: "myTableViewCell", bundle: nil), forCellReuseIdentifier: "PrincipalCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        NetworkProvider.shared.movieDetails(id: 337404)
    }


}

//MARK:- DATA SOURCE
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PrincipalCell") as? myTableViewCell
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
   
}

//MARK:- SELECTED
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Segue", sender: self)
    }
}
