//
//  CollectionInteractor.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/30.
//

class CollectionInteractor {
    func alreadyAdded(trackId:Int) -> Bool {
        var result = false
        let datas = DBDao.shared.queryData(condition: "trackId = \(trackId)")
        if datas.count > 0 {
            result = true
        }
        return result
    }
}
