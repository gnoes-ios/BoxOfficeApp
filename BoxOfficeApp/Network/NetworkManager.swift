//
//  NetworkManager.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/17/25.
//

import Foundation

extension String: @retroactive Error { }


//MARK: - Networking (서버와 통신하는) 클래스 모델
final class NetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = NetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    // MARK: - 박스오피스 정보 불러오기
    func fetchDailyBoxOfficeList() async throws -> [DailyBoxOfficeList] {        
        var components = URLComponents(string: KobisApi.baseURL + KobisApi.dailyBoxOfficePath)
        components?.queryItems = [
            URLQueryItem(name: "key", value: KobisApi.apiKey),
            URLQueryItem(name: "targetDt", value: KobisApi.date)
        ]
        
        
        guard let urlString = components?.url?.absoluteString,
              let url = URL(string: urlString)
        else {
            throw "URL 변환 에러"
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "서버 응답 에러"
        }
        
        guard let movies = try? JSONDecoder().decode(DailyBoxOfficeResponse.self, from: data) else {
            throw "데이터 변환 에러"
        }
        
        return movies.boxOfficeResult.dailyBoxOfficeList
    }
    // MARK: - 영화 정보 불러오기
    func fetchSearchMovie(_ movie: DailyBoxOfficeList) async throws -> MovieSearchResult? {
        var components = URLComponents(string: TmdbApi.baseURL + TmdbApi.searchMoviePath)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: TmdbApi.apiKey),
            URLQueryItem(name: "language", value: TmdbApi.language),
            URLQueryItem(name: "query", value: movie.movieNm),
            URLQueryItem(name: "year", value: String(movie.openDt.prefix(4))),
        ]

        guard let urlString = components?.url?.absoluteString,
              let url = URL(string: urlString)
        else {
            throw "URL 변환 에러"
        }

        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "서버 응답 에러"
        }
        
        guard let movie = try? JSONDecoder().decode(MovieSearchResponse.self, from: data) else {
            throw "데이터 변환 에러"
        }
        
        return movie.results.first
    }
    
    func fetchSearchMovieList(_ keyword: String) async throws -> [MovieSearchResult] {
        var components = URLComponents(string: TmdbApi.baseURL + TmdbApi.searchMoviePath)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: TmdbApi.apiKey),
            URLQueryItem(name: "language", value: TmdbApi.language),
            URLQueryItem(name: "query", value: keyword),
        ]

        guard let urlString = components?.url?.absoluteString else {
            throw "URL 변환 에러"
        }

        let url = URL(string: urlString)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "서버 응답 에러"
        }
        
        guard let movie = try? JSONDecoder().decode(MovieSearchResponse.self, from: data) else {
            throw "데이터 변환 에러"
        }
        
        return movie.results
    }
    // MARK: - 영화 상세 정보 불러오기
    func fetchMovieDetailResponse(_ movieID: Int) async throws -> MovieDetailResponse {
        var components = URLComponents(string: TmdbApi.baseURL + TmdbApi.MovieDetailsPath + "/\(movieID)")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: TmdbApi.apiKey),
            URLQueryItem(name: "language", value: TmdbApi.language),
            URLQueryItem(name: "append_to_response", value: TmdbApi.appendToResponse),
        ]
        
        guard let urlString = components?.url?.absoluteString else {
            throw "URL 변환 에러"
        }
        
        let url = URL(string: urlString)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "서버 응답 에러"
        }
        
        guard let movie = try? JSONDecoder().decode(MovieDetailResponse.self, from: data) else {
            throw "데이터 변환 에러"
        }
        
        return movie
    }
    // MARK: - 영화 이미지 불러오기
    func fetchMovieImageResponse(_ movieID: Int) async throws -> [String] {
        var components = URLComponents(string: TmdbApi.baseURL + TmdbApi.MovieDetailsPath + "/\(movieID)" + "/images")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: TmdbApi.apiKey)
        ]
        
        guard let urlString = components?.url?.absoluteString else {
            throw "URL 변환 에러"
        }
        
        let url = URL(string: urlString)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "서버 응답 에러"
        }
        
        guard let movie = try? JSONDecoder().decode(MovieImageResponse.self, from: data) else {
            throw "데이터 변환 에러"
        }
        
        return movie.backdrops.map { $0.filePath }
    }
    
}
