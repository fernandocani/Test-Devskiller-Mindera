//
//  ServiceMock.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

struct ServiceMock: Service {
    var stubbedLaunches: [Launch] = []
    var stubbedRockets: [Rocket] = []
    var shouldThrowError: Bool = false
    
    private init() { }
    
    static var shared = ServiceMock()
}

extension ServiceMock {
    func getCompanyInfo() async throws -> CompanyInfo {
        if self.shouldThrowError {
            throw APIError.generic("Simulated error")
        }
        
        let jsonFilename: String = "CompanyInfoResponse"
        guard let url = Bundle.main.url(forResource: jsonFilename, withExtension: "json") else {
            throw APIError.invalidURL
        }
        return Utilities.loadStub(url: url)
    }
    
    func getAllLaunches() async throws -> [Launch] {
        if self.shouldThrowError {
            throw APIError.generic("Simulated error")
        }
        if !self.stubbedLaunches.isEmpty {
            return self.stubbedLaunches
        }
        
        let jsonFilename: String = "AllLaunchesResponse"
        guard let url = Bundle.main.url(forResource: jsonFilename, withExtension: "json") else {
            throw APIError.invalidURL
        }
        return Utilities.loadStub(url: url)
    }
    
    func getAllRockets() async throws -> [Rocket] {
        if self.shouldThrowError {
            throw APIError.generic("Simulated error")
        }
        if !self.stubbedLaunches.isEmpty {
            return self.stubbedRockets
        }
        
        let jsonFilename: String = "AllRocketsResponse"
        guard let url = Bundle.main.url(forResource: jsonFilename, withExtension: "json") else {
            throw APIError.invalidURL
        }
        return Utilities.loadStub(url: url)
    }
}
