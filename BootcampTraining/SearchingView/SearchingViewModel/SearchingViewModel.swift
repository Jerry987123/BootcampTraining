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
        movicExpandCellIndex = []
        guard let urlEncodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("searchbarText failed to urlencode.")
            APIDone()
            return
        }
        let taskMovie = DispatchQueue(label: "taskMovie")
        let taskMusic = DispatchQueue(label: "taskMusic")
        let taskGroup = DispatchGroup()
        taskGroup.enter()
        taskMovie.async(group: taskGroup) {
            self.updatedByAPI(term: urlEncodedTerm, mediaType: .movie) {
                taskGroup.leave()
            }
        }
        taskGroup.enter()
        taskMusic.async(group: taskGroup) {
            self.updatedByAPI(term: urlEncodedTerm, mediaType: .music) {
                taskGroup.leave()
            }
        }
        taskGroup.notify(queue: .main) {
            APIDone()
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
