//
//  RalphRobertsTests.swift
//  RalphRobertsTests
//
//  Created by John Scott on 09/05/2018.
//  Copyright © 2018 John Scott. All rights reserved.
//

import XCTest
@testable import RalphRoberts

class RalphRobertsTests: XCTestCase {
    
    func testSingleCharacterRetrieved()
    {
        MarvelConnector.getCharacters(range: 0..<1) { (characters, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(characters)
            XCTAssert(characters?.count == 1, "1 character expected")
        }
    }
    
    func testImageRetrieved()
    {
        let image = MarvelConnector.Image(path: Bundle.main.bundleURL.appendingPathComponent("AppIcon60x60@2x").absoluteString, extension: "png")
        let _ = MarvelConnector.getImage(image: image) { (uiImage) in
            XCTAssertNotNil(uiImage)
        }
    }    
}
