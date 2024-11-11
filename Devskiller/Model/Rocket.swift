//
//  Rocket.swift
//  Devskiller
//
//  Created by Fernando Cani on 05/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

struct Rocket: Decodable {
    let active: Bool
    let payloadWeights: [PayloadWeight]
    let firstFlight: String
    let country: String
    let company: String
    let engines: Engines
    let diameter: Diameter
    let landingLegs: LandingLegs
    let secondStage: SecondStage
    let stages: Int
    let costPerLaunch: Int
    let wikipedia: String
    let name: String
    let type: String
    let boosters: Int
    let successRatePct: Int
    let id: String
    let flickrImages: [String]
    let height: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let description: String

    enum CodingKeys: String, CodingKey {
        case active = "active"
        case payloadWeights = "payload_weights"
        case firstFlight = "first_flight"
        case country = "country"
        case company = "company"
        case engines = "engines"
        case diameter = "diameter"
        case landingLegs = "landing_legs"
        case secondStage = "second_stage"
        case stages = "stages"
        case costPerLaunch = "cost_per_launch"
        case wikipedia = "wikipedia"
        case name = "name"
        case type = "type"
        case boosters = "boosters"
        case successRatePct = "success_rate_pct"
        case id = "id"
        case flickrImages = "flickr_images"
        case height = "height"
        case mass = "mass"
        case firstStage = "first_stage"
        case description = "description"
    }
}

extension Rocket {
    static func stub() -> Rocket {
        Rocket(active: false,
               payloadWeights: [PayloadWeight.stub()],
               firstFlight: "2006-03-24",
               country: "Republic of the Marshall Islands",
               company: "SpaceX",
               engines: Engines.stub(),
               diameter: Diameter.stub(),
               landingLegs: LandingLegs.stub(),
               secondStage: SecondStage.stub(),
               stages: 2,
               costPerLaunch: 6700000,
               wikipedia: "https://en.wikipedia.org/wiki/Falcon_1",
               name: "Falcon 1",
               type: "rocket",
               boosters: 0,
               successRatePct: 40,
               id: "5e9d0d95eda69955f709d1eb",
               flickrImages: [
                "https://imgur.com/DaCfMsj.jpg",
                "https://imgur.com/azYafd8.jpg"
               ],
               height: Diameter.stub(),
               mass: Mass.stub(),
               firstStage: FirstStage.stub(),
               description: "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.")
    }
}

struct Diameter: Decodable {
    let meters: Double?
    let feet: Double?

    enum CodingKeys: String, CodingKey {
        case meters = "meters"
        case feet = "feet"
    }
}

extension Diameter {
    static func stub() -> Diameter {
        Diameter(meters: 1.68, feet: 5.5)
    }
}

struct Engines: Decodable {
    let number: Int
    let layout: String?
    let propellant2: String
    let thrustToWeight: Double
    let thrustSeaLevel: Thrust
    let engineLossMax: Int?
    let version: String
    let type: String
    let propellant1: String
    let isp: ISP
    let thrustVacuum: Thrust

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case layout = "layout"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
        case thrustSeaLevel = "thrust_sea_level"
        case engineLossMax = "engine_loss_max"
        case version = "version"
        case type = "type"
        case propellant1 = "propellant_1"
        case isp = "isp"
        case thrustVacuum = "thrust_vacuum"
    }
}

extension Engines {
    static func stub() -> Engines {
        Engines(number: 1,
                layout: "single",
                propellant2: "RP-1 kerosene",
                thrustToWeight: 96,
                thrustSeaLevel: Thrust.stub(),
                engineLossMax: 0,
                version: "1C",
                type: "merlin",
                propellant1: "liquid oxygen",
                isp: ISP.stub(),
                thrustVacuum: Thrust.stub())
    }
}

struct ISP: Decodable {
    let seaLevel: Int
    let vacuum: Int

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum = "vacuum"
    }
}

extension ISP {
    static func stub() -> ISP {
        ISP(seaLevel: 267,
            vacuum: 304)
    }
}

struct Thrust: Decodable {
    let kN: Int
    let lbf: Int

    enum CodingKeys: String, CodingKey {
        case kN = "kN"
        case lbf = "lbf"
    }
}

extension Thrust {
    static func stub() -> Thrust {
        Thrust(kN: 420,
               lbf: 94000)
    }
}

struct FirstStage: Decodable {
    let thrustVacuum: Thrust
    let engines: Int
    let thrustSeaLevel: Thrust
    let reusable: Bool
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case thrustVacuum = "thrust_vacuum"
        case engines = "engines"
        case thrustSeaLevel = "thrust_sea_level"
        case reusable = "reusable"
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

extension FirstStage {
    static func stub() -> FirstStage {
        FirstStage(thrustVacuum: Thrust.stub(),
                   engines: 1,
                   thrustSeaLevel: Thrust.stub(),
                   reusable: false,
                   fuelAmountTons: 44.3,
                   burnTimeSEC: 169)
    }
}

struct LandingLegs: Decodable {
    let number: Int
    let material: String?

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case material = "material"
    }
}

extension LandingLegs {
    static func stub() -> LandingLegs {
        LandingLegs(number: 4,
                    material: "carbon fiber")
    }
}

struct Mass: Decodable {
    let lb: Int
    let kg: Int

    enum CodingKeys: String, CodingKey {
        case lb = "lb"
        case kg = "kg"
    }
}

extension Mass {
    static func stub() -> Mass {
        Mass(lb: 66460,
             kg: 30146)
    }
}

struct PayloadWeight: Decodable {
    let id: String
    let kg: Int
    let name: String
    let lb: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case kg = "kg"
        case name = "name"
        case lb = "lb"
    }
}

extension PayloadWeight {
    static func stub() -> PayloadWeight {
        PayloadWeight(id: "leo",
                      kg: 450,
                      name: "Low Earth Orbit",
                      lb: 992)
    }
}

struct SecondStage: Decodable {
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
    let engines: Int
    let payloads: Payloads
    let thrust: Thrust
    let reusable: Bool

    enum CodingKeys: String, CodingKey {
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
        case engines = "engines"
        case payloads = "payloads"
        case thrust = "thrust"
        case reusable = "reusable"
    }
}

extension SecondStage {
    static func stub() -> SecondStage {
        SecondStage(fuelAmountTons: 3.38,
                    burnTimeSEC: 378,
                    engines: 1,
                    payloads: Payloads.stub(),
                    thrust: Thrust.stub(),
                    reusable: false)
    }
}

struct Payloads: Decodable {
    let option1: String
    let compositeFairing: CompositeFairing

    enum CodingKeys: String, CodingKey {
        case option1 = "option_1"
        case compositeFairing = "composite_fairing"
    }
}

extension Payloads {
    static func stub() -> Payloads {
        Payloads(option1: "composite fairing",
                 compositeFairing: CompositeFairing.stub())
    }
}

struct CompositeFairing: Decodable {
    let diameter: Diameter
    let height: Diameter

    enum CodingKeys: String, CodingKey {
        case diameter = "diameter"
        case height = "height"
    }
}

extension CompositeFairing {
    static func stub() -> CompositeFairing {
        CompositeFairing(diameter: Diameter.stub(),
                         height: Diameter.stub())
    }
}
