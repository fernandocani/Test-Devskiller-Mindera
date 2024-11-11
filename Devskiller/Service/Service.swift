//
//  Service.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

/// A protocol that defines the necessary methods for fetching.
protocol Service {
    
    /// Fetches company info.
    /// - Returns: `CompanyInfo` object.
    /// - Throws: `APIError` if the fetching fails.
    /// https://api.spacexdata.com/v4/company
    func getCompanyInfo() async throws -> CompanyInfo
    
    /// Fetches all launches.
    /// - Returns: An array of `Launch` objects.
    /// - Throws: `APIError` if the fetching fails.
    func getAllLaunches() async throws -> [Launch]
    
    /// Fetches all rockets.
    /// - Returns: An array of `Rocket` objects.
    /// - Throws: `APIError` if the fetching fails.
    func getAllRockets() async throws -> [Rocket]
}
