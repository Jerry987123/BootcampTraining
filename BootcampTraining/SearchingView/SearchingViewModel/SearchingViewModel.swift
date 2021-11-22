//
//  SearchingViewModel.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import RxSwift
import RxCocoa

class SearchingViewModel {
    var movieObservable = PublishSubject<Result<Any, Error>>()
    var musicObservable = PublishSubject<Result<Any, Error>>()
    var movicExpandCellIndex:[Int] = []
    
    let collectionInteractor = CollectionInteractor()
    let searchingType = ["電影", "音樂"]
    let disposeBag = DisposeBag()
    
    func updatedByAPI(term:String, APIDone:@escaping ()->Void){
        movicExpandCellIndex = []
        guard let urlEncodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("searchbarText failed to urlencode.")
            APIDone()
            return
        }
        
//        Single.zip(
//            self.updatedByAPIByZIP(term: urlEncodedTerm, mediaType: .movie),
//            self.updatedByAPIByZIP(term: urlEncodedTerm, mediaType: .music)
//        ).subscribe { (movie, music) in
//            self.movieObservable.onNext(.success(movie))
//            self.musicObservable.onNext(.success(music))
//            APIDone()
//        }.disposed(by: disposeBag)
        
        
        let taskMovie = DispatchQueue(label: "taskMovie")
        let taskMusic = DispatchQueue(label: "taskMusic")
        let taskGroup = DispatchGroup()
        taskGroup.enter()
        taskMovie.async(group: taskGroup) { [weak self] in
            self?.updatedByAPI(term: urlEncodedTerm, mediaType: .movie) { model in
                self?.movieObservable.onNext(model)
                taskGroup.leave()
            }
        }
        taskGroup.enter()
        taskMusic.async(group: taskGroup) { [weak self] in
            self?.updatedByAPI(term: urlEncodedTerm, mediaType: .music) { model in
                self?.musicObservable.onNext(model)
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
    private func updatedByAPI(term:String, mediaType:SearchingMediaType, callback:@escaping (Result<Any, Error>)->Void){
        iTunesSearchAPI().callAPI(term: term, mediaType: mediaType) { data in
            if let data = data {
                callback(.success(data))
            } else {
                callback(.failure(APIError.unknown))
            }
        } errorHandler: { error in
            if let error = error {
                callback(.failure(error))
            } else {
                callback(.failure(APIError.unknown))
            }
        }
    }
    private func updatedByAPIByZIP(term:String, mediaType:SearchingMediaType) -> Single<[iTunesSearchAPIResponseResult]> {
        .create { (single) -> Disposable in
            iTunesSearchAPI().callAPI(term: term, mediaType: mediaType) { data in
                if let data = data {
                    single(.success((data)))
                } else {
                    single(.failure(APIError.unknown))
                }
            } errorHandler: { error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.failure(APIError.unknown))
                }
            }
            return Disposables.create()
        }
    }
}

enum APIError: Error {
    case unknown
}
