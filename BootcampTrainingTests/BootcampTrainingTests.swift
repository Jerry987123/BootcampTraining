//
//  BootcampTrainingTests.swift
//  BootcampTrainingTests
//
//  Created by ESB21852 on 2021/6/21.
//

import XCTest

class BootcampTrainingTests: XCTestCase {

    override func setUpWithError() throws {
        print("--------------------")
    }

    override func tearDownWithError() throws {
        print("--------------------")
    }

    func testExample() throws {
        DBDaoTest().test()
    }

}
