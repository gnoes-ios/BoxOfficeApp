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
                let releaseDatesInKorea = movieDetail.releaseDates?.results?.filter { $0.iso3166_1 == "KR" }.first?.releaseDates?.filter { $0.type == 3 }.first
                let rating = movieDetail.voteAverage > 0 ? String(format: "%.1f", movieDetail.voteAverage) : "평점 없음"
                
                let director = movieDetail.credits?.crew?.filter { $0.job == "Director" }.first?.name
                let actorsNames = movieDetail.credits?.cast?.prefix(3).compactMap { $0.name }.joined(separator: ", ") ?? "출연 정보 없음"
                
                await MainActor.run {
                    dailyBoxOfficeDetail = DailyBoxOfficeDetail(
                        movieID: movieDetail.id,
                        rank: dailyBoxOfficeInfo?.rank ?? "",
                        title: movieDetail.title ?? "제목 정보 없음",
                        releaseDate: String(releaseDatesInKorea?.releaseDate?.prefix(4) ?? "개봉일 정보 없음"),
                        runtime: movieDetail.runtime ?? 0,
                        genre: genreStringArray.isEmpty ? ["장르 정보 없음"] : genreStringArray,
                        overView: movieDetail.overview.isEmpty ? "줄거리 정보 없음" : movieDetail.overview,
                        rating: rating,
                        posterURl: movieDetail.posterPath ?? "",
                        backgroundImageURL: movieDetail.backdropPath ?? "",
                        videoURL: videoUrlArray?.isEmpty == false ? videoUrlArray : ["영상 정보 없음"],
                        certification: releaseDatesInKorea?.certification ?? "관람등급 정보 없음",
                        director: director ?? "감독 정보 없음",
                        actors: actorsNames
                    )
                }
            } catch {
                if let error = error as? String {
                    print(error)
                }
            }
        }
        
    }
}
