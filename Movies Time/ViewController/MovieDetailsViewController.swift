//
//  MovieDetailsViewController.swift
//  Movies Time
//
//  Created by Jose Eduardo on 07/09/21.
//

import UIKit

class MoviesDetailsViewController: UIViewController {
    
    enum Constants {
        static let padding: CGFloat = 10
        static let color: UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    var movie: Movie?
    var id: Int?
    
    var stackViewPrincipal: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    var firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.posterImageHeightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        self.posterImageHeightConstraint?.isActive = true
        return imageView
    }()
    
    var dateLabel, popularityLabel, budgetLabel, revenueLabel, genresLabel: UILabel!
    
    var overviewText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private var posterImageHeightConstraint: NSLayoutConstraint?
    
    private var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMoviesDetails()
    }
    
    private func loadMoviesDetails() {
        setUp()
        showLoader()
        id = movie?.id
        NetworkProvider.shared.fetchMoviesDetails(id: id ?? 0) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideLoader()
                switch result{
                    case .success(let movieDetails):
                        self?.setUp(movieDetails)
                    case .failure(let error): print(error.localizedDescription)
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
    
    private func setUp(){
        let movieBackgroundView = viewsFor()
        let separationView1 = viewsFor()
        let separationView2 = viewsFor()
        let separationView3 = viewsFor()
        dateLabel = labelFor()
        popularityLabel = labelFor()
        budgetLabel = labelFor()
        revenueLabel = labelFor()
        genresLabel = labelFor()
        
        view.addSubview(movieBackgroundView)
        movieBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        movieBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        movieBackgroundView.addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: movieBackgroundView.topAnchor, constant: Constants.padding).isActive = true
        posterImageView.centerXAnchor.constraint(equalTo: movieBackgroundView.centerXAnchor).isActive = true
        
        movieBackgroundView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: Constants.padding).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: movieBackgroundView.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: movieBackgroundView.leadingAnchor, constant: Constants.padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: movieBackgroundView.trailingAnchor, constant: -Constants.padding).isActive = true
        
        movieBackgroundView.addSubview(stackViewPrincipal)
        stackViewPrincipal.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding).isActive = true
        stackViewPrincipal.leadingAnchor.constraint(equalTo: movieBackgroundView.leadingAnchor).isActive = true
        stackViewPrincipal.trailingAnchor.constraint(equalTo: movieBackgroundView.trailingAnchor).isActive = true
        
        stackViewPrincipal.addArrangedSubview(firstStackView)
        firstStackView.addArrangedSubview(dateLabel)
        firstStackView.addArrangedSubview(popularityLabel)
        popularityLabel.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        stackViewPrincipal.addArrangedSubview(separationView1)
        separationView1.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.2).isActive = true
        
        stackViewPrincipal.addArrangedSubview(budgetLabel)
        stackViewPrincipal.addArrangedSubview(revenueLabel)
        
        stackViewPrincipal.addArrangedSubview(separationView2)
        separationView2.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.2).isActive = true
        
        stackViewPrincipal.addArrangedSubview(genresLabel)
        
        stackViewPrincipal.addArrangedSubview(separationView3)
        separationView3.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.2).isActive = true
        
        stackViewPrincipal.addArrangedSubview(overviewText)
        overviewText.backgroundColor = Constants.color
        
    }
    
    private func setUp(_ movie: MovieDetails){
        
        var genres = " "
        titleLabel.text = movie.title
        posterImageView.setImageFrom(imagePath: movie.poster_path ?? "") { [weak self] in
            guard let self = self,
                  let imageSize = self.posterImageView.image?.size else {
                return
                
            }
            
            let aspectRatio = imageSize.height/imageSize.width
            self.posterImageHeightConstraint?.isActive = false
            self.posterImageHeightConstraint = self.posterImageView.heightAnchor.constraint(equalTo: self.posterImageView.widthAnchor, multiplier: aspectRatio)
            self.posterImageHeightConstraint?.isActive = true
        }
        dateLabel.text = movie.release_date
        popularityLabel.text = "Popularidad: \(Int(movie.vote_average*10)) %"
        budgetLabel.text = "Presupuesto: $ "+String(movie.budget)
        revenueLabel.text = "Recaudación: $ "+String(movie.revenue)
        
        if movie.genres.count > 1 {
            for num in 0 ..< movie.genres.count{
                genres.append("\(movie.genres[num].name), ")
            }
            genres.removeLast()
            genres.removeLast()
        }else{
            genres = movie.genres[0].name
        }
        genresLabel.text = genres
        overviewText.text = movie.overview
    }
    
    private func viewsFor() -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.color
        return view
    }
    
    private func labelFor() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }
}
