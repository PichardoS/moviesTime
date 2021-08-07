//
//  ViewController.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import UIKit
import Kingfisher

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
        let imageURL = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2"
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrincipalCell") as? myTableViewCell
        cell?.accessoryType = .disclosureIndicator
        
        NetworkProvider.shared.showMovies { page in
            cell?.myTitleLabel.text = page.results[indexPath.row].title
            cell?.myDateLabel.text = page.results[indexPath.row].release_date
            cell?.myImage.kf.setImage(with: URL(string: "\(imageURL)\(page.results[indexPath.row].poster_path)"))

        } failure: { error in
            
        }
        
        return cell!
    }
    
   
}

//MARK:- SELECTED
extension ViewController: UITableViewDelegate{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue")
        if segue.destination is movieDetails{
            let vc = segue.destination as! movieDetails
            vc.id = self.id
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Se selecciono")
         NetworkProvider.shared.showMovies { page in
             self.id = page.results[indexPath.row].id
             let name = page.results[indexPath.row].original_title
             print("ID: \(self.id), Name: " + name)
         } failure: { error in
             
         }

//        let vc = movieDetails()
//        vc.id = self.id
//        vc.performSegue(withIdentifier: "Segue", sender: self)
        performSegue(withIdentifier: "Segue", sender: self)

    }
    
}

/*
 print("Se selecciono")
 let vc = storyboard?.instantiateViewController(withIdentifier: "movieDetails") as? movieDetails
 NetworkProvider.shared.showMovies { page in
     vc?.id = page.results[indexPath.row].id
     vc?.name = page.results[indexPath.row].original_title
     print("ID: \(page.results[indexPath.row].id), Name: " + page.results[indexPath.row].original_title)
 } failure: { error in
     
 }
 self.navigationController?.pushViewController(vc!, animated: true)

 */
