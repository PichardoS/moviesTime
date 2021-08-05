//
//  ViewController.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.tableFooterView = UIView()
        myTableView.register(UINib(nibName: "myTableViewCell", bundle: nil), forCellReuseIdentifier: "PrincipalCell")
        myTableView.dataSource = self
        myTableView.delegate = self

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
        
        NetworkProvider.shared.showMovies { page in
            cell?.myTitleLabel.text = page.results[indexPath.row].title
            cell?.myDateLabel.text = page.results[indexPath.row].release_date
            
        } failure: { error in
            
        }
        
        return cell!
    }
    
   
}

//MARK:- SELECTED
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NetworkProvider.shared.showMovies { page in
            self.id = page.results[indexPath.row].id
            let name = page.results[indexPath.row].original_title
            print("ID: \(self.id), Name: " + name)
        } failure: { error in
            
        }
        let vc = movieDetails()
        vc.id = self.id
        vc.performSegue(withIdentifier: "Segue", sender: self)
        //performSegue(withIdentifier: "Segue", sender: self)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      let vc = segue.destination as! movieDetails
    //    vc.id = self.id
    //}
}
