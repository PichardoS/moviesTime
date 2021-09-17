//
//  ViewController.swift
//  Movies Time
//
//  Created by Jose Enrique Montañez Villanueva on 05/09/21.
//

import UIKit

class MoviesListViewController: UITableViewController {
    
    var moviesList: MoviesList?
    
    private var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTable()
        loadMovies()
    }
    
    
    
    private func setupTable() {
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func setupTitle() {
        title = "Top Movies"
    }
    
    private func loadMovies() {
        showLoader()
        NetworkProvider.shared.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.hideLoader()
                switch result {
                case .success(let moviesList):
                    self?.moviesList = moviesList
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    private func showLoader() {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        loader.startAnimating()
        self.loader = loader
    }
    
    private func hideLoader() {
        self.loader?.stopAnimating()
        self.loader?.removeFromSuperview()
        self.loader = nil
    }
    
}

// MARK: - Table View Data Source

extension MoviesListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList?.movies.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        movieCell.movieModel = moviesList?.movies[indexPath.row]
        movieCell.accessoryType = .disclosureIndicator
        
        return movieCell
    }
}

// MARK: - Table View Delegate

extension MoviesListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = MoviesDetailsViewController()
        nextView.movie = moviesList?.movies[indexPath.row]
        self.present(nextView, animated: true, completion: nil)

    }
}
