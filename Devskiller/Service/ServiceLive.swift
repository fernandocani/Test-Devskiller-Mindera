//
//  ServiceLive.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

struct ServiceLive: Service {
    private let baseURL: String = "https://api.spacexdata.com/"
    
    private init() { }
    
    static let shared = ServiceLive()
}

extension ServiceLive {
    func getCompanyInfo() async throws -> CompanyInfo {
        let urlString = self.baseURL + "v4/company"
        let data = try await self.get(urlString: urlString)
        let response = try Utilities.jsonDecoder.decode(CompanyInfo.self, from: data)
        return response
    }
    
    func getAllLaunches() async throws -> [Launch] {
        let urlString = self.baseURL + "v5/launches"
        let data = try await self.get(urlString: urlString)
        let response = try Utilities.jsonDecoder.decode([Launch].self, from: data)
        return response
    }
    
    func getAllRockets() async throws -> [Rocket] {
        let urlString = self.baseURL + "v4/rockets"
        let data = try await self.get(urlString: urlString)
        let response = try Utilities.jsonDecoder.decode([Rocket].self, from: data)
        return response
    }
}

extension ServiceLive {
    private func get(urlString: String,
                     parameters: [String: String]? = nil,
                     queryItems: [URLQueryItem]? = nil) async throws -> Data {
        guard var components = URLComponents(string: urlString) else {
            throw APIError.invalidURL
        }
        components.queryItems = queryItems
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let parameters {
            for (key, value) in parameters {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        let session = try await CertificateHandler.shared.createSessionWithCertificate()
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.generic("DEBUG: invalid HTTPURLResponse")
            }
            guard httpResponse.statusCode == 200 else {
                throw self.handleHTTPError(statusCode: httpResponse.statusCode, data: data)
            }
            return data
        } catch {
            throw error
        }
    }
    
    private func handleHTTPError(statusCode: Int, data: Data) -> Error {
        switch statusCode {
        case 400: return APIError.badRequest
        case 401: return APIError.unauthorized
        case 429: return APIError.rateLimited
        case 500: return APIError.serverError
        default:  return APIError.generic("DEBUG: \(statusCode)")
        }
    }
}
