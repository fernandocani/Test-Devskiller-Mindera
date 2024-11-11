//
//  CompanyInfo.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

struct CompanyInfo: Decodable {
    let headquarters: CompanyInfoHeadquarters
    let links: CompanyInfoLinks
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let vehicles: Int
    let launch_sites: Int
    let test_sites: Int
    let ceo: String
    let cto: String
    let coo: String
    let cto_propulsion: String
    let valuation: Int
    let summary: String
    let id: String
}

extension CompanyInfo {
    static func stub() -> CompanyInfo {
        CompanyInfo(headquarters: CompanyInfoHeadquarters.stub(),
                    links: CompanyInfoLinks.stub(),
                    name: "SpaceX",
                    founder: "Elon Musk",
                    founded: 2002,
                    employees: 8000,
                    vehicles: 3,
                    launch_sites: 3,
                    test_sites: 1,
                    ceo: "Elon Musk",
                    cto: "Elon Musk",
                    coo: "Gwynne Shotwell",
                    cto_propulsion: "Tom Mueller",
                    valuation: 52000000000,
                    summary: "SpaceX designs, manufactures and launches advanced rockets and spacecraft. The company was founded in 2002 to revolutionize space technology, with the ultimate goal of enabling people to live on other planets.",
                    id: "5eb75edc42fea42237d7f3ed")
    }
}

struct CompanyInfoHeadquarters: Decodable {
    let address: String
    let city: String
    let state: String
}

extension CompanyInfoHeadquarters {
    static func stub() -> CompanyInfoHeadquarters {
        CompanyInfoHeadquarters(address: "Rocket Road",
                                city: "Hawthorne",
                                state: "California")
    }
}

struct CompanyInfoLinks: Decodable {
    let website: String
    let flickr: String
    let twitter: String
    let elon_twitter: String
}

extension CompanyInfoLinks {
    static func stub() -> CompanyInfoLinks {
        CompanyInfoLinks(website: "https://www.spacex.com/",
                         flickr: "https://www.flickr.com/photos/spacex/",
                         twitter: "https://twitter.com/SpaceX",
                         elon_twitter: "https://twitter.com/elonmusk")
    }
}
