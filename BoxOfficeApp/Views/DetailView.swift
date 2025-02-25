//
//  DetailView.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/18/25.
//

import UIKit

class DetailView: UIView {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateLabel, runtimeLabel, genreLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let certificationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let certificationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "관람등급"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "감독"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actorsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출연"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "줄거리"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.05697039515, green: 0.05697039515, blue: 0.05697039515, alpha: 1)
    }
    
    private func setupAutoLayout() {
        self.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(2)/CGFloat(3)),
        ])
        
        self.addSubview(movieInfoStackView)
        NSLayoutConstraint.activate([
            movieInfoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            movieInfoStackView.bottomAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: -20)
        ])
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: self.movieInfoStackView.topAnchor, constant: -5)
        ])
        
        self.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: 30),
            ratingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        self.addSubview(ratingTitleLabel)
        NSLayoutConstraint.activate([
            ratingTitleLabel.centerXAnchor.constraint(equalTo: self.ratingLabel.centerXAnchor),
            ratingTitleLabel.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 10)
        ])
        
        self.addSubview(certificationLabel)
        NSLayoutConstraint.activate([
            certificationLabel.centerYAnchor.constraint(equalTo: self.ratingLabel.centerYAnchor),
            certificationLabel.leadingAnchor.constraint(equalTo: self.ratingLabel.trailingAnchor, constant: 40)
        ])
        
        self.addSubview(certificationTitleLabel)
        NSLayoutConstraint.activate([
            certificationTitleLabel.centerXAnchor.constraint(equalTo: self.certificationLabel.centerXAnchor),
            certificationTitleLabel.centerYAnchor.constraint(equalTo: self.ratingTitleLabel.centerYAnchor)
        ])
        
        self.addSubview(directorTitleLabel)
        NSLayoutConstraint.activate([
            directorTitleLabel.topAnchor.constraint(equalTo: self.ratingTitleLabel.bottomAnchor, constant: 40),
            directorTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        self.addSubview(directorLabel)
        NSLayoutConstraint.activate([
            directorLabel.leadingAnchor.constraint(equalTo: self.directorTitleLabel.trailingAnchor, constant: 40),
            directorLabel.centerYAnchor.constraint(equalTo: self.directorTitleLabel.centerYAnchor)
        ])
        
        self.addSubview(actorsTitleLabel)
        NSLayoutConstraint.activate([
            actorsTitleLabel.topAnchor.constraint(equalTo: self.directorTitleLabel.bottomAnchor, constant: 20),
            actorsTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        self.addSubview(actorsLabel)
        NSLayoutConstraint.activate([
            actorsLabel.leadingAnchor.constraint(equalTo: self.actorsTitleLabel.trailingAnchor, constant: 40),
            actorsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            actorsLabel.centerYAnchor.constraint(equalTo: self.actorsTitleLabel.centerYAnchor)
        ])
        
        self.addSubview(overViewTitleLabel)
        NSLayoutConstraint.activate([
            overViewTitleLabel.topAnchor.constraint(equalTo: self.actorsTitleLabel.bottomAnchor, constant: 40),
            overViewTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        self.addSubview(overViewLabel)
        NSLayoutConstraint.activate([
            overViewLabel.topAnchor.constraint(equalTo: self.overViewTitleLabel.bottomAnchor, constant: 10),
            overViewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    func configure(_ movie: DailyBoxOfficeDetail) {
        backgroundImageView.kf.setImage(with: makeImageURL(movie.backgroundImageURL))
        titleLabel.text = movie.title
        releaseDateLabel.text = "\(movie.releaseDate) • "
        runtimeLabel.text = "\(movie.runtime / 60)시간 \(movie.runtime % 60)분 • "
        genreLabel.text = movie.genre.joined(separator: ", ")
        ratingLabel.text = "\(movie.rating)"
        certificationLabel.text = formatCertification(movie.certification)
        overViewLabel.text = movie.overView
        directorLabel.text = movie.director
        actorsLabel.text = movie.actors
    }
    
    private func makeImageURL(_ urlString: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/original/" + urlString)!
    }
    
    private func formatCertification(_ certification: String) -> String {
        switch certification {
        case "ALL":
            return "전체 관람가"
        case "관람등급 정보 없음":
            return "관람등급 정보 없음"
        default:
            return "\(certification)세"
        }
    }

}
