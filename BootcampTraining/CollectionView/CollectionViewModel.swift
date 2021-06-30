//
//  CollectionViewModel.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/25.
//

import RxCocoa

class CollectionViewModel {
    var movieDatas = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
    var musicDatas = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
    var movicExpandCellIndex:[Int] = []
    
    func loadCollectionFromDB(mediaType:SearchingMediaType){
        switch mediaType {
        case .movie:
            let datas = DBDao.shared.queryData(condition: "mediaType = 'movie'")
            self.movieDatas.accept(datas)
        case .music:
            let datas = DBDao.shared.queryData(condition: "mediaType = 'music'")
            self.musicDatas.accept(datas)
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
}
