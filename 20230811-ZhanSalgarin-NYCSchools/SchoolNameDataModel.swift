//
//  File.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import Foundation
//
//
//struct CountryMainModel: Codable {
//    let capital, code: String
//    let currency: Currency
//    let flag: String
//    let language: Language
//    let name: String
//    let region: Region
//    let demonym: String?
//}
//
//// MARK: - Currency
//struct Currency: Codable {
//    let code, name: String
//    let symbol: String?
//}
//
//// MARK: - Language
//struct Language: Codable {
//    let code: String?
//    let name: String
//    let iso6392, nativeName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case code, name
//        case iso6392 = "iso639_2"
//        case nativeName
//    }
//}
//
//enum Region: String, Codable {
//    case af = "AF"
//    case americas = "Americas"
//    case an = "AN"
//    case empty = ""
//    case eu = "EU"
//    case na = "NA"
//    case oc = "OC"
//    case regionAS = "AS"
//    case sa = "SA"
//}
//
//typealias Cityb = [CountryMainModel]


//struct SchoolDataModel: Codable {
//    let dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore: String
//
//    let satMathAvgScore, satWritingAvgScore: String
//
//    enum CodingKeys: String, CodingKey {
//        case dbn
//        case schoolName = "school_name"
//        case numOfSatTestTakers = "num_of_sat_test_takers"
//        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
//        case satMathAvgScore = "sat_math_avg_score"
//        case satWritingAvgScore = "sat_writing_avg_score"
//    }
//}
//
//typealias Welcome = [SchoolDataModel]

struct SchoolNameDataModel: Codable {
    let dbn: String
    let school_name: String
}
