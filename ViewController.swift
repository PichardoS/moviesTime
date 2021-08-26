//
//  ViewController.swift
//  moviesTime
//
//  Created by Jose Eduardo on 30/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    var id = Int()
    var list = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkProvider.shared.showMoviesList { page in
            self.list = page.results
        } failure: { err in
            print(err.debugDescription)
        }

        
        myTableView.tableFooterView = UIView()
        myTableView.register(UINib(nibName: "myTableViewCell", bundle: nil), forCellReuseIdentifier: "PrincipalCell")
        myTableView.dataSource = self
        myTableView.delegate = self

    }


}

//MARK:- DATA SOURCE
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kImageURL = ConfigValues.get().ImageURL
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrincipalCell") as? myTableViewCell
        cell?.accessoryType = .disclosureIndicator

        NetworkProvider.shared.showMoviesList { page in
            self.list = page.results
            cell?.myTitleLabel.text = String(indexPath.row + 1) + ". " + page.results[indexPath.row].title
            cell?.myDateLabel.text = page.results[indexPath.row].release_date
            let URLCompleted = kImageURL+page.results[indexPath.row].poster_path
            cell?.myImage.downloaded(from: URL(string: URLCompleted)!)

        } failure: { error in
            cell?.myTitleLabel.text = error.debugDescription
            cell?.myDateLabel.text = " "
        }

        return cell!
    }
    
   
}

//MARK:- SELECTED
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "Segue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? movieDetails{
            destination.list = list[myTableView.indexPathForSelectedRow!.row]
        }

    }
    
}

//MARK:- Download images
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
