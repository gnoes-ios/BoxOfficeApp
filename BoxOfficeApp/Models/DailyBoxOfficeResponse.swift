//
//  DailyBoxOfficeResponse.swift
//  BoxOfficeApp
//
//  Created by 박주성 on 2/17/25.
//

import Foundation

// MARK: - DailyBoxOfficeResponse
struct DailyBoxOfficeResponse: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank, movieNm, openDt: String
    let salesAcc, salesShare: String
    let audiCnt, audiAcc: String
}
