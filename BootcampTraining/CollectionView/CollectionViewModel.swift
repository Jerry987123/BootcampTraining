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
    
    func loadCollectionFromDB(mediaType:SearchingMediaType){
        switch mediaType {
        case .movie:
            let datas = DBDao.shared.queryData(condition: nil)
            self.movieDatas.accept(datas)
        case .music:
            let datas = DBDao.shared.queryData(condition: nil)
            self.musicDatas.accept(datas)
        }
    }
}
