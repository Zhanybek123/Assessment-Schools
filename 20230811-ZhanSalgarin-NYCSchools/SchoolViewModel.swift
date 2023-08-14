//
//  SchoolViewModel.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by zhanybek salgarin on 8/11/23.
//

import Foundation

enum SchoolDataError: Error {
    case custom(error: Error)
    case failedToDecode
    case invalidStatusCode
    
    var errorDescription: String {
        switch self {
        case .custom(let error):
            return error.localizedDescription
        case .failedToDecode:
            return "Failed to decode response"
        case .invalidStatusCode:
            return "Invalid status code"
        }
    }
}

protocol CountryViewModelProtocol: AnyObject {
    var schools: [SchoolNameDataModel] { get }
    var didDataLoad: (() -> Void)? { get set }
    var didErrorOccur: ((Error) -> Void)? { get set }
    var schoolScore: [SchoolScoresDataModel] { get }
    
    func fetchData()
    func fetchScoreData(schoolDBN: String)
}

class CountryViewModel: CountryViewModelProtocol {
    
    var schools: [SchoolNameDataModel] = []
    var didDataLoad: (() -> Void)?
    var didErrorOccur: ((Error) -> Void)?
    private var allSchools: [SchoolNameDataModel] = []
    var schoolScore: [SchoolScoresDataModel] = []
    
    func fetchData() {
        Task{
            let schoolResult = await fetchSchoolNameData()
            switch schoolResult {
            case let .success(schools):
                self.schools = schools
                await MainActor.run {
                    self.didDataLoad?()
                }
            case let .failure(error):
                print(error.localizedDescription)
                await MainActor.run {
                    self.didErrorOccur?(error)
                }
            }
        }
    }
    
    func fetchScoreData(schoolDBN: String) {
        Task {
            let schoolScoreResult = try await fetchSchoolScoreData(schoolDBN: schoolDBN)
            switch schoolScoreResult {
            case let .success(schoolScores):
                await MainActor.run(body: {
                    self.schoolScore = schoolScores
                    self.didDataLoad?()
                })
            case let .failure(error):
                print(error.localizedDescription)
                await MainActor.run {
                    self.didErrorOccur?(error)
                }
            }
        }
    }
    
    func fetchSchoolNameData() async -> Result<[SchoolNameDataModel], Error> {
        let url = URL(string: Constants.completeSchoolURL)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            guard let schools = try? decoder.decode([SchoolNameDataModel].self, from: data) else {
                throw SchoolDataError.failedToDecode
            }
            return .success(schools)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchSchoolScoreData(schoolDBN: String) async throws -> Result<[SchoolScoresDataModel], Error> {
        guard let url = URL(string: "\(Constants.schoolsScoreURL)\(schoolDBN)") else {
            throw SchoolDataError.invalidStatusCode
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decode = JSONDecoder()
            guard let schoolScoreResults = try? decode.decode([SchoolScoresDataModel].self, from: data) else {
                throw SchoolDataError.failedToDecode
            }
            return .success(schoolScoreResults)
        } catch {
            return .failure(error)
        }
    }
}


