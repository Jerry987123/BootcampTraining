//
//  SearchingViewModel.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import RxCocoa

class SearchingViewModel {
    var movieDatas = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
    var musicDatas = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
    
    func updatedByAPI(term:String){
        updatedByAPI(term: term, mediaType: .movie)
        updatedByAPI(term: term, mediaType: .music)
    }
    private func updatedByAPI(term:String, mediaType:SearchingMediaType){
        iTunesSearchAPI().callAPI(term: term, mediaType: mediaType) { datas in
            if let datas = datas {
                switch mediaType {
                case .movie:
                    self.movieDatas.accept(datas)
                case .music:
                    self.musicDatas.accept(datas)
                }
            }
        }
    }
}
