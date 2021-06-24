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
    
    func updatedByAPI(term:String, callback:@escaping (_ state:Bool)->Void){
        var movieState = false
        var musicState = false
        updatedByAPI(term: term, mediaType: .movie) { state in
            if musicState {
                callback(true)
            } else {
                movieState = true
            }
        }
        updatedByAPI(term: term, mediaType: .music) { state in
            if movieState {
                callback(true)
            } else {
                musicState = true
            }
        }
    }
    private func updatedByAPI(term:String, mediaType:SearchingMediaType, callback:@escaping (_ state:Bool)->Void){
        iTunesSearchAPI().callAPI(term: term, mediaType: mediaType) { datas in
            callback(true)
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
