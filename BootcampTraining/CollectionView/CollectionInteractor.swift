//
//  CollectionInteractor.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/30.
//

class CollectionInteractor {
    func alreadyAdded(trackId:Int) -> Bool {
        var result = false
        let dbResult = DBDao.shared.queryData(condition: "trackId = \(trackId)")
        switch dbResult {
        case .success(let datas):
            if datas.count > 0 {
                result = true
            }
        case .failure(let error):
            print("db error=\(error.localizedDescription)")
        }
        return result
    }
}
