//
//  DetailViewController.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/18/25.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    @Published var dailyBoxOfficeInfo: DailyBoxOfficeInfo?
    @Published var dailyBoxOfficeDetail: DailyBoxOfficeDetail?
    var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindingsInfo()
    }
    
    private func setupBindingsInfo() {
        $dailyBoxOfficeInfo
            .receive(on: RunLoop.main)
            .sink { [weak self] movie in
                guard let self = self, let movieID = movie?.movieID else { return }
                self.fetchDailyBoxOfficeDetail(movieID)
            }
            .store(in: &subscriptions)
        
        $dailyBoxOfficeDetail
            .receive(on: RunLoop.main)
            .sink { [weak self] movie in
                guard let self = self, let movie = movie else { return }
                self.detailView.configure(movie)
            }
            .store(in: &subscriptions)
    }


    private func fetchDailyBoxOfficeDetail(_ movieID: Int) {      
        Task {
            
            do {
                let movieDetail = try await NetworkManager.shared.fetchMovieDetail(movieID)
                
                let genreStringArray = movieDetail.genres.map { $0.name }
                let videoUrlArray = movieDetail.videos?.results?.map { $0.key }
                
                await MainActor.run {
                    dailyBoxOfficeDetail = DailyBoxOfficeDetail(movieID: movieDetail.id,
                                                                rank: dailyBoxOfficeInfo?.rank ?? "",
                                                                title: movieDetail.title ?? "",
                                                                releaseDate: movieDetail.releaseDate ?? "",
                                                                genre: genreStringArray,
                                                                overView: movieDetail.overview,
                                                                rating: movieDetail.voteAverage,
                                                                posterURl: movieDetail.posterPath ?? "",
                                                                backgroundImageURL: movieDetail.backdropPath ?? "",
                                                                videoURL: videoUrlArray)
                }
            }
            catch {
                if let error = error as? String {
                    print(error)
                }
            }
        }
        
    }


}
