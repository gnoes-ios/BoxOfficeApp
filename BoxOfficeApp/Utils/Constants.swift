//
//  Constants.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/17/25.
//

import Foundation
    
struct KobisApi {
    static let baseURL: String = "https://kobis.or.kr/kobisopenapi"
    static let dailyBoxOfficePath: String = "/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let SearchMoviePath: String = "/webservice/rest/movie/searchMovieList"
    static let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "KobisApiKey") as! String
    
    static var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        return dateFormatter.string(from: yesterday)
    }
    
    private init() {}
}

struct TmdbApi {
    static let baseURL: String = "https://api.themoviedb.org/3"
    static let searchMoviePath: String = "/search/movie?"
    static let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "TmdbApiKey") as! String
    static let language: String = "ko-KR"
    
    private init() {}
}

struct Cell {
    static let moviePosterCellID = "MoviePosterCell"
    
    private init() {}
}
