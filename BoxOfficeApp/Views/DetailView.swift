//
//  DetailView.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/18/25.
//

import UIKit

class DetailView: UIView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private let stillsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "스틸컷"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stillsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        collectionView.backgroundColor = .clear
        collectionView.register(StillsCell.self, forCellWithReuseIdentifier: Cell.stillsCellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let trailerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "트레일러"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trailerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        collectionView.backgroundColor = .clear
        collectionView.register(TrailerPlayerCell.self, forCellWithReuseIdentifier: Cell.TrailerPlayerCellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    enum Section { case main }
    typealias Item = String
    var trailerDatasource: UICollectionViewDiffableDataSource<Section, Item>!
    var stillsDatasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionView()
        setupUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        stillsDatasource = UICollectionViewDiffableDataSource<Section, Item>.init(collectionView: stillsCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.stillsCellID, for: indexPath) as! StillsCell
            
            cell.configure(item)
            
            return cell
        })
        
        trailerDatasource = UICollectionViewDiffableDataSource<Section, Item>.init(collectionView: trailerCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.TrailerPlayerCellID, for: indexPath) as! TrailerPlayerCell
            
            cell.configure(item)
            
            return cell
        })
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 16, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.05697039515, green: 0.05697039515, blue: 0.05697039515, alpha: 1)
    }
    
    private func setupAutoLayout() {
        self.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
        
        self.contentView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: CGFloat(2)/CGFloat(3)),
        ])
        
        self.contentView.addSubview(movieInfoStackView)
        NSLayoutConstraint.activate([
            movieInfoStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            movieInfoStackView.bottomAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: -20)
        ])
        
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: self.movieInfoStackView.topAnchor, constant: -5)
        ])
        
        self.contentView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: 30),
            ratingLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
        
        self.contentView.addSubview(ratingTitleLabel)
        NSLayoutConstraint.activate([
            ratingTitleLabel.centerXAnchor.constraint(equalTo: self.ratingLabel.centerXAnchor),
            ratingTitleLabel.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 10)
        ])
        
        self.contentView.addSubview(certificationLabel)
        NSLayoutConstraint.activate([
            certificationLabel.centerYAnchor.constraint(equalTo: self.ratingLabel.centerYAnchor),
            certificationLabel.leadingAnchor.constraint(equalTo: self.ratingLabel.trailingAnchor, constant: 40)
        ])
        
        self.contentView.addSubview(certificationTitleLabel)
        NSLayoutConstraint.activate([
            certificationTitleLabel.centerXAnchor.constraint(equalTo: self.certificationLabel.centerXAnchor),
            certificationTitleLabel.centerYAnchor.constraint(equalTo: self.ratingTitleLabel.centerYAnchor)
        ])
        
        self.contentView.addSubview(directorTitleLabel)
        NSLayoutConstraint.activate([
            directorTitleLabel.topAnchor.constraint(equalTo: self.ratingTitleLabel.bottomAnchor, constant: 40),
            directorTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        self.contentView.addSubview(directorLabel)
        NSLayoutConstraint.activate([
            directorLabel.leadingAnchor.constraint(equalTo: self.directorTitleLabel.trailingAnchor, constant: 40),
            directorLabel.centerYAnchor.constraint(equalTo: self.directorTitleLabel.centerYAnchor)
        ])
        
        self.contentView.addSubview(actorsTitleLabel)
        NSLayoutConstraint.activate([
            actorsTitleLabel.topAnchor.constraint(equalTo: self.directorTitleLabel.bottomAnchor, constant: 20),
            actorsTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
        
        self.contentView.addSubview(actorsLabel)
        NSLayoutConstraint.activate([
            actorsLabel.leadingAnchor.constraint(equalTo: self.actorsTitleLabel.trailingAnchor, constant: 40),
            actorsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            actorsLabel.centerYAnchor.constraint(equalTo: self.actorsTitleLabel.centerYAnchor)
        ])
        
        self.contentView.addSubview(overViewTitleLabel)
        NSLayoutConstraint.activate([
            overViewTitleLabel.topAnchor.constraint(equalTo: self.actorsTitleLabel.bottomAnchor, constant: 40),
            overViewTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
        
        self.contentView.addSubview(overViewLabel)
        NSLayoutConstraint.activate([
            overViewLabel.topAnchor.constraint(equalTo: self.overViewTitleLabel.bottomAnchor, constant: 10),
            overViewLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
        
        self.contentView.addSubview(stillsTitleLabel)
        NSLayoutConstraint.activate([
            stillsTitleLabel.topAnchor.constraint(equalTo: self.overViewLabel.bottomAnchor, constant: 40),
            stillsTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
        
        self.contentView.addSubview(stillsCollectionView)
        NSLayoutConstraint.activate([
            stillsCollectionView.topAnchor.constraint(equalTo: self.stillsTitleLabel.bottomAnchor, constant: 10),
            stillsCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stillsCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stillsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        self.contentView.addSubview(trailerTitleLabel)
        NSLayoutConstraint.activate([
            trailerTitleLabel.topAnchor.constraint(equalTo: self.stillsCollectionView.bottomAnchor),
            trailerTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
        
        self.contentView.addSubview(trailerCollectionView)
        NSLayoutConstraint.activate([
            trailerCollectionView.topAnchor.constraint(equalTo: self.trailerTitleLabel.bottomAnchor, constant: 10),
            trailerCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            trailerCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            trailerCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -40),
            trailerCollectionView.heightAnchor.constraint(equalToConstant: 200)
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
        applyStillsDatasource(movie.imageURLs)
        applyTrailerDatasource(movie.videoURL)
    }
    
    private func applyTrailerDatasource(_ urls: [String] = []) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(urls, toSection: .main)
        self.trailerDatasource.apply(snapshot)
    }
    
    private func applyStillsDatasource(_ urls: [String] = []) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(urls, toSection: .main)
        self.stillsDatasource.apply(snapshot)
    }
    
    private func makeImageURL(_ urlString: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w1280/" + urlString)!
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
