//
//  SearchingViewModel.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import RxSwift

class SearchingViewModel {
    var movieObservable = PublishSubject<Result<Any, Error>>()
    var musicObservable = PublishSubject<Result<Any, Error>>()
    var movicExpandCellIndex:[Int] = []
    
    let collectionInteractor = CollectionInteractor()
    let searchingType = ["電影", "音樂"]
    
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
        taskMovie.async(group: taskGroup) { [weak self] in
            self?.updatedByAPI(term: urlEncodedTerm, mediaType: .movie) {
                taskGroup.leave()
            }
        }
        taskGroup.enter()
        taskMusic.async(group: taskGroup) { [weak self] in
            self?.updatedByAPI(term: urlEncodedTerm, mediaType: .music) {
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
    func alreadyAddedInDB(trackId:Int) -> Bool {
        return collectionInteractor.alreadyAdded(trackId: trackId)
    }
    private func updatedByAPI(term:String, mediaType:SearchingMediaType, APIDone:@escaping ()->Void){
        iTunesSearchAPI().callAPI(term: term, mediaType: mediaType) { [weak self] data in
            APIDone()
            if let data = data {
                switch mediaType {
                case .movie:
                    self?.movieObservable.onNext(.success(data))
                case .music:
                    self?.musicObservable.onNext(.success(data))
                }
            }
        } errorHandler: { [weak self] error in
            APIDone()
            if let error = error {
                switch mediaType {
                case .movie:
                    self?.movieObservable.onNext(.failure(error))
                case .music:
                    self?.musicObservable.onNext(.failure(error))
                }
            }
        }
    }
}
