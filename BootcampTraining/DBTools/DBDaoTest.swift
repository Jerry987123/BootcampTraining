//
//  DBDaoTest.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/28.
//

class DBDaoTest {
    func test(){
//        insert()
//        update()
        query()
//        delete()
    }
    private func insert(){
        var models = [iTunesSearchAPIResponseResult]()
        for _ in 1...3 {
            let model = iTunesSearchAPIResponseResult()
            model.trackName = "trackName"
            model.artistName = "artName"
            model.collectionName = "collectionName"
            model.trackTimeMillis = NSNumber(100)
            model.longDescription = "longdescription"
            model.artworkUrl100 = "artworkurl100"
            model.trackViewUrl = "trackviewurl"
            models.append(model)
        }
        DBDao.shared.insertData(mediaType: .music, models: models)
    }
    private func update(){
        let model = CollectionDBModel()
        model.id = 6
        model.mediaType = "music"
        model.trackName = "BtrackName"
        model.artistName = "BartName"
        model.collectionName = "BcollectionName"
        model.trackTimeMillis = NSNumber(200)
        model.longDescription = "Blongdescription"
        model.artworkUrl100 = "Bartworkurl100"
        model.trackViewUrl = "Btrackviewurl"
        DBDao.shared.updateData(model: model)
    }
    private func query(){
        let condition = "id = 6"
        let results = DBDao.shared.queryData(condition: condition)
        print(results)
    }
    private func delete(){
        let model = CollectionDBModel()
        model.id = 7
        DBDao.shared.deleteData(model: model)
    }
}
