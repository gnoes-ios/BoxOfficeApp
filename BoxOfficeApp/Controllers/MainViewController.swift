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
    
    @Published var dailyBoxOfficeInfos: [DailyBoxOfficeInfo] = []
    var subscriptions = Set<AnyCancellable>()
    
    enum Section { case main }
    typealias Item = DailyBoxOfficeInfo
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 dd일"
        return formatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        setupBindings()
        fetchDailyBoxOfficeInfos()
    }
    
    private func setupUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.05697039515, green: 0.05697039515, blue: 0.05697039515, alpha: 1)
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "\(formattedDate) 박스오피스"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.shadowColor = .darkGray
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        self.view.addSubview(collectionView)
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
            
            cell.configure(item, false)
            
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupBindings() {
        $dailyBoxOfficeInfos
            .receive(on: RunLoop.main)
            .map { movies in
                movies.sorted {
                    (Int($0.rank) ?? 0) < (Int($1.rank) ?? 0)
                }
            }
            .sink { [weak self] sortedMovies in
                guard let self = self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(sortedMovies, toSection: .main)
                self.datasource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }
    
    private func fetchDailyBoxOfficeInfos() {
        Task {
            do {
                let boxOfficeMovies = try await NetworkManager.shared.fetchDailyBoxOfficeList()
                dailyBoxOfficeInfos = try await fetchMovieSearchResults(boxOfficeMovies)
            } catch {
                if let error = error as? String {
                    print(error)
                }
            }
        }
    }
    
    private func fetchMovieSearchResults(_ boxOfficeMovies: [DailyBoxOfficeList]) async throws -> [DailyBoxOfficeInfo] {
        return try await withThrowingTaskGroup(of: (DailyBoxOfficeList, MovieSearchResult?).self) { group in
            var movies: [DailyBoxOfficeInfo] = []
            
            for boxOfficeMovie in boxOfficeMovies {
                group.addTask {
                    let movieSearchList = try await NetworkManager.shared.fetchSearchMovie(boxOfficeMovie)
                    return (boxOfficeMovie, movieSearchList)
                }
            }
            
            for try await movie in group {
                movies.append(DailyBoxOfficeInfo(
                    movieID: movie.1?.id ?? 0,
                    rank: movie.0.rank,
                    posterURL: movie.1?.posterPath ?? "",
                    title: movie.1?.title ?? "",
                    releaseDate: movie.0.openDt
                ))
            }
            
            return movies
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sortedMovies = dailyBoxOfficeInfos.sorted {
            (Int($0.rank) ?? 0) < (Int($1.rank) ?? 0)
        }
        
        let detailVC = DetailViewController()
        detailVC.dailyBoxOfficeInfo = sortedMovies[indexPath.row]
        
        present(detailVC, animated: true)
    }
}
