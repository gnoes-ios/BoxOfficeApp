//
//  MainViewController.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/17/25.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        collectionView.backgroundColor = .clear
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: Cell.moviePosterCellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    @Published var dailyBoxOfficeDetails: [DailyBoxofficeDetail] = []
    var subscriptions = Set<AnyCancellable>()
    
    enum Section {
        case main
    }
    typealias Item = DailyBoxofficeDetail
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        setupBindings()
        fetchDailyBoxOfficeDetails()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .darkGray
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>.init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.moviePosterCellID, for: indexPath) as! MoviePosterCell
            
            cell.configure(item, showTitle: false)
            
            return cell
        })
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 70, leading: 0, bottom: 0, trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupBindings() {
        $dailyBoxOfficeDetails
            .receive(on: RunLoop.main) // 메인 스레드에서 실행
            .map { movies in
                // movies 배열을 rank 기준으로 오름차순 정렬
                movies.sorted {
                    (Int($0.rank) ?? 0) < (Int($1.rank) ?? 0)
                }
            }
            .sink { [weak self] sortedMovies in
                // NSDiffableDataSourceSnapshot 업데이트
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(sortedMovies, toSection: .main)
                self?.datasource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }
    
    private func fetchDailyBoxOfficeDetails() {
        Task {
            do {
                let boxOfficeMovies = try await NetworkManager.shared.fetchDailyBoxOfficeList()
                dailyBoxOfficeDetails = try await fetchMovieSearchResults(boxOfficeMovies)
            }
            catch {
                if let error = error as? String {
                    print(error)
                }
            }
            
        }
        
        func fetchMovieSearchResults(_ boxOfficeMovies: [DailyBoxOfficeList]) async throws -> [DailyBoxofficeDetail] {
            return try await withThrowingTaskGroup(of: (DailyBoxOfficeList, MovieSearchResult?).self) { group in
                var movies: [DailyBoxofficeDetail] = []
                
                for boxOfficeMovie in boxOfficeMovies {
                    group.addTask {
                        let movieSearchList = try await NetworkManager.shared.fetchSearchMovie(boxOfficeMovie)
                        return (boxOfficeMovie, movieSearchList)
                    }
                }
                
                for try await movie in group {
                    movies.append(DailyBoxofficeDetail(rank: movie.0.rank,
                                                       posterURL: movie.1?.posterPath ?? "",
                                                       title: movie.1?.title ?? "",
                                                       releaseDate: movie.0.openDt))
                }
                
                return movies
            }
        }
    }
    
}

