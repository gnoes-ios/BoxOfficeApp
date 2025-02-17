//
//  MoviePosterCell.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/17/25.
//

import UIKit
import Kingfisher

class MoviePosterCell: UICollectionViewCell {
    
    private let PosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rankContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.transform = CGAffineTransform(rotationAngle: .pi / 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영화제목"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let PosterContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉: "
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubview(PosterContainerView)
        NSLayoutConstraint.activate([
            PosterContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            PosterContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            PosterContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            PosterContainerView.heightAnchor.constraint(equalTo: PosterContainerView.widthAnchor, multiplier: 1.5)
        ])
    
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: PosterContainerView.bottomAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        PosterContainerView.addSubview(PosterImageView)
        NSLayoutConstraint.activate([
            PosterImageView.topAnchor.constraint(equalTo: PosterContainerView.topAnchor),
            PosterImageView.leadingAnchor.constraint(equalTo: PosterContainerView.leadingAnchor),
            PosterImageView.trailingAnchor.constraint(equalTo: PosterContainerView.trailingAnchor),
            PosterImageView.bottomAnchor.constraint(equalTo: PosterContainerView.bottomAnchor)
        ])
        
        PosterContainerView.addSubview(rankContainerView)
        NSLayoutConstraint.activate([
            rankContainerView.centerXAnchor.constraint(equalTo: PosterContainerView.leadingAnchor),
            rankContainerView.centerYAnchor.constraint(equalTo: PosterContainerView.topAnchor),
            rankContainerView.widthAnchor.constraint(equalToConstant: 100),
            rankContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        PosterContainerView.addSubview(rankLabel)
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: PosterContainerView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: PosterContainerView.leadingAnchor),
            rankLabel.widthAnchor.constraint(equalToConstant: 36),
            rankLabel.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        contentView.addSubview(releaseDateLabel)
        NSLayoutConstraint.activate([
            releaseDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
    }
 
    func configure(_ movie: DailyBoxofficeDetail, showTitle: Bool) {
        PosterImageView.kf.setImage(with: makeImageURL(movie.posterURL))
        titleLabel.text = movie.title
        rankLabel.text = movie.rank
        releaseDateLabel.text = "\(movie.releaseDate) 개봉"
        
        titleLabel.isHidden = showTitle // stackView 내부에서 자동으로 공간 제거
    }
    
    func makeImageURL(_ urlString: String) -> URL {
        
        return URL(string: "https://image.tmdb.org/t/p/original/" + urlString)!
    }

    
}
