//
//  MoviePosterCell.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/17/25.
//

import UIKit
import Kingfisher

class MoviePosterCell: UICollectionViewCell {
    
    private let PosterContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let PosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var rankContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.transform = CGAffineTransform(rotationAngle: .pi / 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉: "
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabelTopConstraint: NSLayoutConstraint!
    private var releaseDateTopConstraint: NSLayoutConstraint!
    private var posterHeightConstraint: NSLayoutConstraint!
    private var PosterContainerViewBottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        self.contentView.addSubview(PosterContainerView)
        PosterContainerViewBottomConstraint = PosterContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30)
        NSLayoutConstraint.activate([
            PosterContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            PosterContainerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            PosterContainerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            PosterContainerViewBottomConstraint
        ])
    
        self.PosterContainerView.addSubview(PosterImageView)
        NSLayoutConstraint.activate([
            PosterImageView.topAnchor.constraint(equalTo: self.PosterContainerView.topAnchor),
            PosterImageView.leadingAnchor.constraint(equalTo: self.PosterContainerView.leadingAnchor),
            PosterImageView.trailingAnchor.constraint(equalTo: self.PosterContainerView.trailingAnchor),
            PosterImageView.heightAnchor.constraint(equalTo: self.PosterImageView.widthAnchor, multiplier: 1.5)
        ])
        
        self.PosterContainerView.addSubview(rankContainerView)
        NSLayoutConstraint.activate([
            rankContainerView.centerXAnchor.constraint(equalTo: self.PosterContainerView.leadingAnchor),
            rankContainerView.centerYAnchor.constraint(equalTo: self.PosterContainerView.topAnchor),
            rankContainerView.widthAnchor.constraint(equalToConstant: 100),
            rankContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        self.PosterContainerView.addSubview(rankLabel)
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: self.PosterContainerView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: self.PosterContainerView.leadingAnchor),
            rankLabel.widthAnchor.constraint(equalToConstant: 36),
            rankLabel.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        self.PosterContainerView.addSubview(titleLabel)
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: self.PosterImageView.bottomAnchor, constant: 35)
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])

        self.PosterContainerView.addSubview(releaseDateLabel)
        releaseDateTopConstraint = releaseDateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5)
        NSLayoutConstraint.activate([
            releaseDateTopConstraint,
            releaseDateLabel.centerXAnchor.constraint(equalTo: self.PosterContainerView.centerXAnchor)
        ])
    }
 
    func configure(_ movie: DailyBoxOfficeInfo, _ isPosterOnlyMode: Bool) {
        self.PosterImageView.kf.setImage(with: makeImageURL(movie.posterURL))
        self.titleLabel.text = movie.title
        self.rankLabel.text = movie.rank
        self.releaseDateLabel.text = "\(movie.releaseDate) 개봉"
        
        updateLayout(for: isPosterOnlyMode)
    }
    
    private func updateLayout(for isPosterOnlyMode: Bool) {
        self.rankContainerView.isHidden = isPosterOnlyMode
        self.rankLabel.isHidden = isPosterOnlyMode
        self.releaseDateLabel.isHidden = isPosterOnlyMode
        
        if isPosterOnlyMode {
            titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
            titleLabelTopConstraint.constant = 5
            releaseDateTopConstraint.constant = 0
            PosterContainerViewBottomConstraint.constant = 0
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            titleLabelTopConstraint.constant = 30
            releaseDateTopConstraint.constant = 5
            PosterContainerViewBottomConstraint.constant = -50
        }
    }

    private func makeImageURL(_ urlString: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w780/" + urlString)!
    }
}
