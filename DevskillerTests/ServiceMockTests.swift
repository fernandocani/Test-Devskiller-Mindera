//
//  ServiceMockTests.swift
//  DevskillerTests
//
//  Created by Fernando Cani on 11/11/2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import XCTest
@testable import Devskiller

class ServiceMockTests: XCTestCase {

    var service: ServiceMock!

    override func setUp() {
        super.setUp()
        service = ServiceMock.shared
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testGetCompanyInfoSuccess() async throws {
        // Arrange
        let expectedCompanyInfo = CompanyInfo.stub()
        service.stubbedLaunches = []
        service.shouldThrowError = false
        
        // Act
        let companyInfo = try await service.getCompanyInfo()
        
        // Assert
        XCTAssertEqual(companyInfo.headquarters.address, expectedCompanyInfo.headquarters.address)
        XCTAssertEqual(companyInfo.headquarters.city, expectedCompanyInfo.headquarters.city)
        XCTAssertEqual(companyInfo.headquarters.state, expectedCompanyInfo.headquarters.state)
        XCTAssertEqual(companyInfo.links.website, expectedCompanyInfo.links.website)
        XCTAssertEqual(companyInfo.links.flickr, expectedCompanyInfo.links.flickr)
        XCTAssertEqual(companyInfo.links.twitter, expectedCompanyInfo.links.twitter)
        XCTAssertEqual(companyInfo.links.elon_twitter, expectedCompanyInfo.links.elon_twitter)
        XCTAssertEqual(companyInfo.name, expectedCompanyInfo.name)
        XCTAssertEqual(companyInfo.founder, expectedCompanyInfo.founder)
        XCTAssertEqual(companyInfo.founded, expectedCompanyInfo.founded)
        XCTAssertEqual(companyInfo.employees, expectedCompanyInfo.employees)
        XCTAssertEqual(companyInfo.vehicles, expectedCompanyInfo.vehicles)
        XCTAssertEqual(companyInfo.launch_sites, expectedCompanyInfo.launch_sites)
        XCTAssertEqual(companyInfo.test_sites, expectedCompanyInfo.test_sites)
        XCTAssertEqual(companyInfo.ceo, expectedCompanyInfo.ceo)
        XCTAssertEqual(companyInfo.cto, expectedCompanyInfo.cto)
        XCTAssertEqual(companyInfo.coo, expectedCompanyInfo.coo)
        XCTAssertEqual(companyInfo.cto_propulsion, expectedCompanyInfo.cto_propulsion)
        XCTAssertEqual(companyInfo.valuation, expectedCompanyInfo.valuation)
        XCTAssertEqual(companyInfo.summary, expectedCompanyInfo.summary)
        XCTAssertEqual(companyInfo.id, expectedCompanyInfo.id)
        
    }
    
    func testGetCompanyInfoFailure() async throws {
        // Arrange
        service.shouldThrowError = true
        
        // Act & Assert
        do {
            _ = try await service.getCompanyInfo()
            XCTFail("Expected error, but got success.")
        } catch let error as APIError {
            XCTAssertEqual(error, APIError.generic("Simulated error"))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testGetAllLaunchesSuccess() async throws {
        // Arrange
        let expectedLaunch = Launch.stub()
        service.stubbedLaunches = [expectedLaunch]
        
        // Act
        let launches = try await service.getAllLaunches()
        
        // Assert
        XCTAssertEqual(launches[0].fairings?.reused, expectedLaunch.fairings?.reused)
        XCTAssertEqual(launches[0].fairings?.recoveryAttempt, expectedLaunch.fairings?.recoveryAttempt)
        XCTAssertEqual(launches[0].fairings?.recovered, expectedLaunch.fairings?.recovered)
        XCTAssertEqual(launches[0].fairings?.ships, expectedLaunch.fairings?.ships)
        XCTAssertEqual(launches[0].links.patch.small, expectedLaunch.links.patch.small)
        XCTAssertEqual(launches[0].links.patch.large, expectedLaunch.links.patch.large)
        XCTAssertEqual(launches[0].links.reddit.campaign, expectedLaunch.links.reddit.campaign)
        XCTAssertEqual(launches[0].links.reddit.launch, expectedLaunch.links.reddit.launch)
        XCTAssertEqual(launches[0].links.reddit.media, expectedLaunch.links.reddit.media)
        XCTAssertEqual(launches[0].links.reddit.recovery, expectedLaunch.links.reddit.recovery)
        XCTAssertEqual(launches[0].links.flickr.small, expectedLaunch.links.flickr.small)
        XCTAssertEqual(launches[0].links.flickr.original, expectedLaunch.links.flickr.original)
        XCTAssertEqual(launches[0].links.presskit, expectedLaunch.links.presskit)
        XCTAssertEqual(launches[0].links.webcast, expectedLaunch.links.webcast)
        XCTAssertEqual(launches[0].links.youtubeID, expectedLaunch.links.youtubeID)
        XCTAssertEqual(launches[0].links.article, expectedLaunch.links.article)
        XCTAssertEqual(launches[0].links.wikipedia, expectedLaunch.links.wikipedia)
        XCTAssertEqual(launches[0].staticFireDateUTC, expectedLaunch.staticFireDateUTC)
        XCTAssertEqual(launches[0].staticFireDateUnix, expectedLaunch.staticFireDateUnix)
        XCTAssertEqual(launches[0].net, expectedLaunch.net)
        XCTAssertEqual(launches[0].window, expectedLaunch.window)
        XCTAssertEqual(launches[0].rocket, expectedLaunch.rocket)
        XCTAssertEqual(launches[0].success, expectedLaunch.success)
        XCTAssertEqual(launches[0].failures.count, expectedLaunch.failures.count)
        XCTAssertEqual(launches[0].details, expectedLaunch.details)
        XCTAssertEqual(launches[0].crew.count, expectedLaunch.crew.count)
        XCTAssertEqual(launches[0].ships, expectedLaunch.ships)
        XCTAssertEqual(launches[0].capsules, expectedLaunch.capsules)
        XCTAssertEqual(launches[0].payloads, expectedLaunch.payloads)
        XCTAssertEqual(launches[0].launchpad, expectedLaunch.launchpad)
        XCTAssertEqual(launches[0].flightNumber, expectedLaunch.flightNumber)
        XCTAssertEqual(launches[0].name, expectedLaunch.name)
        XCTAssertEqual(launches[0].dateUTC, expectedLaunch.dateUTC)
        XCTAssertEqual(launches[0].dateUnix, expectedLaunch.dateUnix)
        XCTAssertEqual(launches[0].datePrecision, expectedLaunch.datePrecision)
        XCTAssertEqual(launches[0].upcoming, expectedLaunch.upcoming)
        XCTAssertEqual(launches[0].cores.count, expectedLaunch.cores.count)
        XCTAssertEqual(launches[0].autoUpdate, expectedLaunch.autoUpdate)
        XCTAssertEqual(launches[0].tbd, expectedLaunch.tbd)
        XCTAssertEqual(launches[0].launchLibraryID, expectedLaunch.launchLibraryID)
        XCTAssertEqual(launches[0].id, expectedLaunch.id)
    }

    func testGetAllLaunchesFailure() async throws {
        // Arrange
        service.shouldThrowError = true
        
        // Act & Assert
        do {
            _ = try await service.getAllLaunches()
            XCTFail("Expected error, but got success.")
        } catch let error as APIError {
            XCTAssertEqual(error, APIError.generic("Simulated error"))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
