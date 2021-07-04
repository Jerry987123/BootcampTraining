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
        let result = DBDao.shared.queryData(condition: condition)
        switch result {
        case .success(let datas):
            print(datas)
            if datas.count == 1 {
                assert(true)
            } else if datas.count > 1 {
                assert(false, "以唯一值做query，查出二筆以上資料")
            } else {
                assert(false, "query未找到資料")
            }
        case .failure(let error):
            assert(false, error.localizedDescription)
        }
    }
    private func delete(){
        let trackId = 1
        let result = DBDao.shared.deleteData(trackId: trackId)
        switch result {
        case .success:
            assert(true)
        case .failure(let error):
            assert(false, "delete未成功, error=\(error.localizedDescription)")
        }
    }
}
