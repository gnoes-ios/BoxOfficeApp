//
//  DailyBoxofficeDetail.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/18/25.
//

import Foundation

struct DailyBoxOfficeDetail: Hashable {
    let movieID: Int
    let rank: String
    let title: String
    let releaseDate: String
    let runtime: Int
    let genre: [String]
    let overView: String
    let rating: String
    let imageURLs: [String]
    let backgroundImageURL: String
    let videoURL: [String]
    let certification: String
    let director: String
    let actors: String
}
