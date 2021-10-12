//
//  ProductHuntUITests.swift
//  ProductHuntUITests
//
//  Created by Alfredo E. Pérez Leal on 26/09/2021.
//

import XCTest

class ProductHuntUITests: XCTestCase {
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
