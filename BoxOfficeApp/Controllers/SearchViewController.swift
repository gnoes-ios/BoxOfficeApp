//
//  SearchViewController.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/18/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        embedSearchControl()
        configureCollectionView()
        bind()
    }
    
    private func setupUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.05697039515, green: 0.05697039515, blue: 0.05697039515, alpha: 1)
        
        configureNavigationBar()
        configureTabBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "\(formattedDate) 박스오피스"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.shadowColor = .darkGray
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func configureTabBar() {
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = .black
        tabAppearance.shadowColor = .darkGray
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        
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
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.moviePosterCellID, for: indexPath) as! MoviePosterCell
            
            cell.configure(item, true)
            return cell
        }
    }
    
    private func embedSearchControl() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화 제목을 검색하세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.spellCheckingType = .no
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.8))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count: 2)
        groupLayout.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 10
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func bind() {
        $dailyBoxOfficeInfos
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(result, toSection: .main)
                self.datasource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }
    
    private func fetchDailyBoxOfficeInfos(_ keyword: String) {
        var movies: [DailyBoxOfficeInfo] = []
        
        Task {
            do {
                let searchMovieList = try await NetworkManager.shared.fetchSearchMovieList(keyword)
                
                for searchMovie in searchMovieList {
                    let moviePoster = searchMovie.posterPath ?? ""
                    let movieTitle = searchMovie.title ?? ""
                    let releaseDate = searchMovie.releaseDate ?? ""
                    
                    movies.append(DailyBoxOfficeInfo(
                        movieID: searchMovie.id,
                        rank: "",
                        posterURL: moviePoster,
                        title: movieTitle,
                        releaseDate: releaseDate
                    ))
                }
                
                await MainActor.run {
                    dailyBoxOfficeInfos = movies
                }
            } catch {
                if let error = error as? String {
                    print(error)
                }
            }
        }
    }
    
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text, !keyword.isEmpty else {
            dailyBoxOfficeInfos = []
            return
        }
        
        fetchDailyBoxOfficeInfos(keyword)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.dailyBoxOfficeInfo = dailyBoxOfficeInfos[indexPath.row]
        
        present(detailVC, animated: true)
    }
}
