//
//  DailyBoxOfficeDetail.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/17/25.
//

import Foundation

struct DailyBoxofficeDetail: Identifiable, Hashable {
    let id = UUID()
    let rank: String
    let posterURL: String
    let title: String
    let releaseDate: String
}
