//
//  CollectionViewModel.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/25.
//

import RxCocoa

enum CollectingActionIndex {
    case collect
    case cancelCollet
}
class CollectionViewModel {
    var movieData = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
    var musicData = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
    var movicExpandCellIndex:[Int] = []
    
    func loadCollectionFromDB(mediaType:SearchingMediaType){
        switch mediaType {
        case .movie:
            let result = DBDao.shared.queryData(condition: "mediaType = 'movie'")
            switch result {
            case .success(let data):
                movieData.accept(data)
            case .failure(let error):
                print("db query error=\(error.localizedDescription)")
            }
        case .music:
            let result = DBDao.shared.queryData(condition: "mediaType = 'music'")
            switch result {
            case .success(let data):
                musicData.accept(data)
            case .failure(let error):
                print("db query error=\(error.localizedDescription)")
            }
        }
    }
    func appendExpandCellIndex(index:Int){
        if !movicExpandCellIndex.contains(index){
            movicExpandCellIndex.append(index)
        }
    }
    func removeExpandCellIndex(index:Int){
        if let expandCellIndexInRecord = movicExpandCellIndex.firstIndex(of: index){
            movicExpandCellIndex.remove(at: expandCellIndexInRecord)
        }
    }
    func collectionDBInsertOrDelete(model:iTunesSearchAPIResponseResult, collectingAction:CollectingActionIndex, mediaType:SearchingMediaType) -> Result<Bool, CustomError> {
        var result = Result<Bool, CustomError>.success(true)
        switch collectingAction {
        case .collect:
            result = DBDao.shared.insertData(mediaType: mediaType, model: model)
        case .cancelCollet:
            result = DBDao.shared.deleteData(trackId: Int(truncating: model.trackId))
        }
        return result
    }
}
