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
        guard let urlEncodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("searchbarText failed to urlencode.")
            callback(true)
            return
        }
        updatedByAPI(term: urlEncodedTerm, mediaType: .movie) { state in
            if musicState {
                callback(true)
            } else {
                movieState = true
            }
        }
        updatedByAPI(term: urlEncodedTerm, mediaType: .music) { state in
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
