//
//  DBDaoTest.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/28.
//

import XCTest
@testable import BootcampTraining

class DBDaoTest:XCTestCase {
    override func setUpWithError() throws {
        print("--------------------")
    }

    override func tearDownWithError() throws {
        print("--------------------")
    }

    func testDBInsert(){
        let model = iTunesSearchAPIResponseResult()
        model.trackName = "trackName"
        model.artistName = "artName"
        model.collectionName = "collectionName"
        model.trackTimeMillis = NSNumber(300)
        model.longDescription = "longdescription"
        model.artworkUrl100 = "artworkurl100"
        model.trackViewUrl = "trackviewurl"
        model.trackId = NSNumber(1)
        let result = DBDao.shared.insertData(mediaType: .music, model: model)
        switch result {
        case .success(_):
            XCTAssert(true, "success")
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    func testDBQuery(){
        let condition = "trackId = 1"
        let result = DBDao.shared.queryData(condition: condition)
        switch result {
        case .success(let data):
            if data.count == 1 {
                XCTAssert(true)
            } else if data.count > 1 {
                XCTAssert(false, "以唯一值做query，查出二筆以上資料")
            } else {
                XCTAssert(false, "query未找到資料")
            }
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
    func testDBDelete() throws {
        let trackId = 1
        let result = DBDao.shared.deleteData(trackId: trackId)
        switch result {
        case .success:
            XCTAssert(true)
        case .failure(let error):
            XCTAssert(false, "delete未成功, error=\(error.localizedDescription)")
        }
    }
}
