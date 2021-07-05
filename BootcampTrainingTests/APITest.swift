//
//  APITest.swift
//  BootcampTrainingTests
//
//  Created by Jayyi on 2021/7/6.
//

import XCTest
@testable import BootcampTraining

class APITest:XCTestCase {
    override func setUpWithError() throws {
        print("--------------------")
    }

    override func tearDownWithError() throws {
        print("--------------------")
    }

    func testAPI(){
        let exp = expectation(description: "myExpectation")
        
        let term = "apple"
        let mediaType = SearchingMediaType.music
        let url = "https://itunes.apple.com/search?term=\(term)&media=\(mediaType.rawValue)&country=TW"
        iTunesSearchAPIObj().callITunesAPI(url) { response in
            exp.fulfill()
            if let response = response {
                XCTAssert(response.results.count > 0 , "搜尋關鍵字Apple但沒資料")
            } else {
                XCTFail("API response 為nil")
            }
        } errorHandler: { error in
            exp.fulfill()
            XCTAssert(false, error?.localizedDescription ?? "error is nil")
        }
        wait(for: [exp], timeout: 4.0)
    }
}

