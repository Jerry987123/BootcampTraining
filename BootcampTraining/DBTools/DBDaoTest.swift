//
//  DBDaoTest.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/28.
//

class DBDaoTest {
    func test(){
        insert()
        query()
        delete()
    }
    private func insert(){
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
            assert(true, "success")
        case .failure(let error):
            assert(false, error.localizedDescription)
        }
    }
    private func query(){
        let condition = "trackId = 1"
        let results = DBDao.shared.queryData(condition: condition)
        if results.count == 1 {
            assert(true)
        } else if results.count > 1 {
            assert(false, "以唯一值做query，查出二筆以上資料")
        } else {
            assert(false, "query未找到資料")
        }
        print(results)
    }
    private func delete(){
        let trackId = 1
        DBDao.shared.deleteData(trackId: trackId)
        let condition = "trackId = \(trackId)"
        let results = DBDao.shared.queryData(condition: condition)
        if results.count == 0 {
            assert(true)
        } else {
            assert(false, "delete未成功")
        }
    }
}
