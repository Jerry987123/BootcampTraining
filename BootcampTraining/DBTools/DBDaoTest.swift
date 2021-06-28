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
//        delete()
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
        model.trackId = NSNumber(123)
        DBDao.shared.insertData(mediaType: .music, model: model)
    }
    private func query(){
        let condition = "id = 1"
        let results = DBDao.shared.queryData(condition: condition)
        print(results)
    }
    private func delete(){
        let trackId = 123
        DBDao.shared.deleteData(trackId: trackId)
    }
}
