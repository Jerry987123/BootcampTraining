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
    var movicExpandCellIndex:[Int] = []
    
    func updatedByAPI(term:String, APIDone:@escaping ()->Void){
        var movieState = false
        var musicState = false
        movicExpandCellIndex = []
        guard let urlEncodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("searchbarText failed to urlencode.")
            APIDone()
            return
        }
        updatedByAPI(term: urlEncodedTerm, mediaType: .movie) {
            if musicState {
                APIDone()
            } else {
                movieState = true
            }
        }
        updatedByAPI(term: urlEncodedTerm, mediaType: .music) {
            if movieState {
                APIDone()
            } else {
                musicState = true
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
    private func updatedByAPI(term:String, mediaType:SearchingMediaType, APIDone:@escaping ()->Void){
        iTunesSearchAPI().callAPI(term: term, mediaType: mediaType) { datas in
            APIDone()
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
