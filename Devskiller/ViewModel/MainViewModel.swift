//
//  MainViewModel.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

/// ViewModel for managing data.
final class MainViewModel: NSObject {
    
    private(set) var service: Service
    private(set) var launches: [Launch] = []
    private(set) var filteredLaunches: [Launch] = []
    private(set) var rockets: [Rocket] = []
    private(set) var companyInfo: CompanyInfo?
    private(set) var launchYears: [Int] = []
    
    private(set) var selectedYear: Int?
    private(set) var isSuccessful: Bool?
    private(set) var sortAscending: Bool = false

    /// Initializes the ViewModel with a specified service.
    /// - Parameter service: The service to be used for fetching.
    init(_ service: Service) {
        self.service = service
        super.init()
    }
}

// MARK: - Data Loading
extension MainViewModel {
    func initialLoad() async throws {
        async let companyInfo = await self.service.getCompanyInfo()
        async let launches = await self.service.getAllLaunches()
        async let rockets = await self.service.getAllRockets()
        let result = try await (companyInfo: companyInfo, launches: launches, rockets: rockets)
        self.setCompanyInfo(result.companyInfo)
        self.setLaunches(result.launches)
        self.setRockets(result.rockets)
    }
    
    func loadCompanyInfo() async throws {
        self.setCompanyInfo(try await self.service.getCompanyInfo())
    }
    
    func loadAllLaunches() async throws {
        self.setLaunches(try await self.service.getAllLaunches())
    }
    
    func loadAllRockets() async throws {
        self.setRockets(try await self.service.getAllRockets())
    }
}

// MARK: - Data Setting
private extension MainViewModel {
    func setCompanyInfo(_ companyInfo: CompanyInfo) {
        self.companyInfo = companyInfo
    }
    
    func setLaunches(_ launches: [Launch]) {
        let sortedLaunches = launches.sorted(by: { $0.dateUnix > $1.dateUnix })
        self.launchYears = Array(Set(sortedLaunches.map {
            Calendar.current.component(.year, from: $0.dateUTC ?? Date())
        })).sorted(by: { $0 > $1 } )
        self.launches = sortedLaunches
        self.filteredLaunches = sortedLaunches
    }
    
    func setRockets(_ rockets: [Rocket]) {
        self.rockets = rockets
    }
}

// MARK: - Filtering & Sorting
extension MainViewModel {
    func applyYearFilter(year: Int?) {
        self.selectedYear = year
        self.filterLaunches()
    }

    func applySortOrder(ascending: Bool) {
        self.sortAscending = ascending
        self.sortFilteredLaunches()
    }
    
    func applySuccessFilter(success: Bool?) {
        self.isSuccessful = success
        self.filterLaunches()
    }
    
    private func filterLaunches() {
        self.filteredLaunches = self.launches
        if let year = self.selectedYear {
            self.filteredLaunches = self.filteredLaunches.filter {
                Calendar.current.component(.year, from: $0.dateUTC ?? Date()) == year
            }
        }
        if let isSuccessful = isSuccessful {
            self.filteredLaunches = self.filteredLaunches.filter { $0.success == isSuccessful }
        }
        self.sortFilteredLaunches()
    }

    private func sortFilteredLaunches() {
        self.filteredLaunches = self.filteredLaunches.sorted {
            self.sortAscending ? $0.dateUnix < $1.dateUnix : $0.dateUnix > $1.dateUnix
        }
    }
    
}
