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
    var movieData = PublishRelay<[iTunesSearchAPIResponseResult]>()
    var musicData = PublishRelay<[iTunesSearchAPIResponseResult]>()
    var movicExpandCellIndex:[Int] = []
    
    let collectionInteractor = CollectionInteractor()
    
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
    func getTableDataIndex(trackId:Int, data:[iTunesSearchAPIResponseResult]) -> Int? {
        var dataIndex:Int?
        for (i, obj) in data.enumerated() {
            if let objTrackId = obj.trackId, Int(truncating: objTrackId) == trackId {
                dataIndex = i
                break
            }
        }
        return dataIndex
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
    func alreadyAddedInDB(trackId:Int) -> Bool {
        return collectionInteractor.alreadyAdded(trackId: trackId)
    }
}
