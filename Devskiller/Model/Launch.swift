//
//  Launch.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

// MARK: - Launch
struct Launch: Decodable {
    let fairings: LaunchFairings?
    let links: LaunchLinks
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool
    let window: Int?
    let rocket: String
    let success: Bool?
    let failures: [LaunchFailure]
    let details: String?
    let crew: [LaunchCrew]
    let ships: [String]
    let capsules: [String]
    let payloads: [String]
    let launchpad: String
    let flightNumber: Int
    let name: String
    let dateUTC: Date?
    let dateUnix: Int
    let datePrecision: String
    let upcoming: Bool
    let cores: [LaunchCore]
    let autoUpdate: Bool
    let tbd: Bool
    let launchLibraryID: String?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case fairings, links, net, window, rocket, success, failures, details, crew, ships, capsules, payloads, launchpad, name, upcoming, cores, tbd, id
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case flightNumber = "flight_number"
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case datePrecision = "date_precision"
        case autoUpdate = "auto_update"
        case launchLibraryID = "launch_library_id"
    }
}

extension Launch {
    static func stub() -> Launch {
        Launch(fairings: LaunchFairings.stub(),
               links: LaunchLinks.stub(),
               staticFireDateUTC: "2021-02-24T12:25:00.000Z",
               staticFireDateUnix: 1614169500,
               net: false,
               window: 0,
               rocket: "5e9d0d95eda69973a809d1ec",
               success: true,
               failures: [LaunchFailure.stub()],
               details: "This mission launches the sixteenth batch of operational Starlink satellites, which are version 1.0, from LC-39A. It is the eighteenth Starlink launch overall. The satellites will be delivered to low Earth orbit and will spend a few weeks maneuvering to their operational altitude. The booster is expected to land on an ASDS.",
               crew: [LaunchCrew.stub()],
               ships: [
                "5ea6ed2f080df4000697c90d",
                "5ea6ed30080df4000697c913"
               ],
               capsules: [
                "5e9e2c5df359188aba3b2676"
               ],
               payloads: [
                "5fbfedc654ceb10a5664c814"
               ],
               launchpad: "5e9e4501f509094ba4566f84",
               flightNumber: 119,
               name: "Starlink-20 (v1.0)",
               dateUTC: self.getDate(from: "2021-03-11T08:13:00.000Z"),
               dateUnix: 1615450380,
               datePrecision: "hour",
               upcoming: false,
               cores: [LaunchCore.stub()],
               autoUpdate: true,
               tbd: false,
               launchLibraryID: "134eb787-244e-4131-8b03-c9fbd0a11efc",
               id: "600f9a718f798e2a4d5f979d")
    }
    
    private static func getDate(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.date(from: string)
    }
}

// MARK: - LaunchFairings
struct LaunchFairings: Decodable {
    let reused: Bool?
    let recoveryAttempt: Bool?
    let recovered: Bool?
    let ships: [String]
    
    enum CodingKeys: String, CodingKey {
        case reused, recovered, ships
        case recoveryAttempt = "recovery_attempt"
    }
}

extension LaunchFairings {
    static func stub() -> LaunchFairings {
        LaunchFairings(reused: false,
                       recoveryAttempt: true,
                       recovered: true,
                       ships: [
                        "5ea6ed2e080df4000697c908",
                        "5ea6ed2f080df4000697c90c"
                       ])
    }
}

// MARK: - LaunchLinks
struct LaunchLinks: Decodable {
    let patch: LaunchLinksPatch
    let reddit: LaunchLinksReddit
    let flickr: LaunchLinksFlickr
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?
    
    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast, article, wikipedia
        case youtubeID = "youtube_id"
    }
}

extension LaunchLinks {
    static func stub() -> LaunchLinks {
        LaunchLinks(patch: LaunchLinksPatch.stub(),
                    reddit: LaunchLinksReddit.stub(),
                    flickr: LaunchLinksFlickr.stub(),
                    presskit: "https://www.nasa.gov/sites/default/files/atoms/files/spacex_crs-21_mision_overview_high_res.pdf",
                    webcast: "https://youtu.be/aVFPzTDCihQ",
                    youtubeID: "aVFPzTDCihQ",
                    article: "https://spaceflightnow.com/2020/11/21/international-satellite-launches-to-extend-measurements-of-sea-level-rise/",
                    wikipedia: "https://en.wikipedia.org/wiki/Copernicus_Sentinel-6")
    }
}

struct LaunchLinksPatch: Decodable {
    let small: String?
    let large: String?
}

extension LaunchLinksPatch {
    static func stub() -> LaunchLinksPatch {
        LaunchLinksPatch(small: "https://images2.imgbox.com/96/40/667HXq7w_o.png",
                         large: "https://images2.imgbox.com/26/73/pypHBlGD_o.png")
    }
}

struct LaunchLinksReddit: Decodable {
    let campaign: String?
    let launch: String?
    let media: String?
    let recovery: String?
}

extension LaunchLinksReddit {
    static func stub() -> LaunchLinksReddit {
        LaunchLinksReddit(campaign: "https://www.reddit.com/r/spacex/comments/jkk93v/sentinel6_michael_freilich_launch_campaign_thread/",
                          launch: "https://www.reddit.com/r/spacex/comments/jxsche/rspacex_sentinel6_official_launch_discussion/",
                          media: "https://www.reddit.com/r/spacex/comments/jyd67q/rspacex_sentinel6_media_thread_photographer/",
                          recovery: nil)
    }
}

struct LaunchLinksFlickr: Decodable {
    let small: [String]
    let original: [String]
}

extension LaunchLinksFlickr {
    static func stub() -> LaunchLinksFlickr {
        LaunchLinksFlickr(small: [],
                          original: [
                            "https://farm9.staticflickr.com/8617/16789019815_f99a165dc5_o.jpg",
                            "https://farm8.staticflickr.com/7619/16763151866_35a0a4d8e1_o.jpg",
                            "https://farm9.staticflickr.com/8569/16169086873_4d8829832e_o.png"
                          ])
    }
}

// MARK: - LaunchFailure
struct LaunchFailure: Decodable {
    let time: Int
    let altitude: Int?
    let reason: String
}

extension LaunchFailure {
    static func stub() -> LaunchFailure {
        LaunchFailure(time: 33,
                      altitude: nil,
                      reason: "merlin engine failure")
    }
}

// MARK: - LaunchCrew
struct LaunchCrew: Decodable {
    let crew: String
    let role: String
}

extension LaunchCrew {
    static func stub() -> LaunchCrew {
        LaunchCrew(crew: "5ebf1a6e23a9a60006e03a7a",
                   role: "Joint Commander")
    }
}

// MARK: - LaunchCore
struct LaunchCore: Decodable {
    let core: String?
    let flight: Int?
    let gridfins: Bool?
    let legs: Bool?
    let reused: Bool?
    let landingAttempt: Bool?
    let landingSuccess: Bool?
    let landingType: String?
    let landpad: String?
    
    enum CodingKeys: String, CodingKey {
        case core, flight, gridfins, legs, reused, landpad
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
    }
}

extension LaunchCore {
    static func stub() -> LaunchCore {
        LaunchCore(core: "5e9e289ef3591814873b2625",
                   flight: 1,
                   gridfins: false,
                   legs: false,
                   reused: false,
                   landingAttempt: false,
                   landingSuccess: nil,
                   landingType: nil,
                   landpad: nil)
    }
}
