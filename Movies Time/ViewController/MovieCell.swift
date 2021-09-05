//
//  MovieCell.swift
//  Movies Time
//
//  Created by Jose Enrique Montañez Villanueva on 05/09/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var movieModel: Movie? {
        didSet {
            guard let movieModel = movieModel else { return }
            setupViews(movieModel)
        }
    }
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    enum Constants {
        static let padding: CGFloat = 10
    }
    
    var movieBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.posterImageHeightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        self.posterImageHeightConstraint?.isActive = true
        
        return imageView
    }()
    
    private var posterImageHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func prepareForReuse() {
        
    }
    
    private func setupViews(_ movieModel: Movie) {
        titleLabel.text = movieModel.title
        posterImageView.setImageFrom(imagePath: movieModel.posterImageString) { [weak self] in
            guard let self = self,
                  let imageSize = self.posterImageView.image?.size else {
                return
                
            }
            
            let aspectRatio = imageSize.height/imageSize.width
            self.posterImageHeightConstraint?.isActive = false
            self.posterImageHeightConstraint = self.posterImageView.heightAnchor.constraint(equalTo: self.posterImageView.widthAnchor, multiplier: aspectRatio)
            self.posterImageHeightConstraint?.isActive = true
        }
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        contentView.addSubview(movieBackgroundView)
        movieBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding).isActive = true
        movieBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding).isActive = true
        movieBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding).isActive = true
        movieBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding).isActive = true
        
        movieBackgroundView.addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: movieBackgroundView.topAnchor, constant: Constants.padding).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: movieBackgroundView.leadingAnchor, constant: Constants.padding).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: movieBackgroundView.bottomAnchor, constant: -Constants.padding).isActive = true
        
        movieBackgroundView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: Constants.padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: movieBackgroundView.trailingAnchor, constant: -Constants.padding).isActive = true
        
    }
}
