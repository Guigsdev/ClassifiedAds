//
//  ClassifiedAdsTests.swift
//  ClassifiedAdsTests
//
//  Created by Guillaume-Webwag on 19/07/2022.
//

import XCTest
@testable import ClassifiedAds

class ClassifiedAdsTests: XCTestCase {

    let testAdsMockFileName = "TestAds"
    let testCategoriesMockFileName = "TestCategories"
    let testFileType = "json"

    var decoder: JSONDecoder!
    var adsData: Data!
    var categoriesData: Data!

    override func setUpWithError() throws {
        let adsMockURL = Bundle.main.url(forResource: testAdsMockFileName, withExtension: testFileType)!
        let categoriesMockURL = Bundle.main.url(forResource: testCategoriesMockFileName, withExtension: testFileType)!
        do {
            adsData = try Data(contentsOf: adsMockURL)
            categoriesData = try Data(contentsOf: categoriesMockURL)
        } catch {
            throw error
        }
        decoder = JSONDecoder()
    }

    override func tearDownWithError() throws {
        adsData = nil
        categoriesData = nil
    }

    func testDecodingListings() throws {
        decoder.dateDecodingStrategy = .iso8601
        do {
            let ads = try decoder.decode([ClassifiedAds.ClassifiedAd].self, from: adsData)
            XCTAssertNotEqual(ads.count, 0)
        } catch {
            throw error
        }
    }

    func testDecodingCategories() throws {
        do {
            let categories = try decoder.decode([ClassifiedAds.Category].self, from: categoriesData)
            XCTAssertNotEqual(categories.count, 0)
        } catch {
            throw error
        }
    }
}
