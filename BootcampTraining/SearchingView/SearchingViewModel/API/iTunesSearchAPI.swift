//
//  iTunesSearchAPI.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

import RxSwift

enum SearchingMediaType: String {
    case movie = "movie"
    case music = "music"
}
class iTunesSearchAPI {
    func callAPI(term:String, mediaType:SearchingMediaType, callback:@escaping(_ results:[iTunesSearchAPIResponseResult]?)->(), errorHandler:@escaping(_ error:Error?)->()){
        let url = "https://itunes.apple.com/search?term=\(term)&media=\(mediaType.rawValue)&country=TW"
        iTunesSearchAPIObj().callITunesAPI(url) { results in
            if let data = results?.results {
                callback(data)
            } else {
                callback(nil)
            }
        } errorHandler: { error in
            errorHandler(error)
        }
    }
    
    func callAPIRxSwift(term: String, mediaType: SearchingMediaType) -> Single<Result<Any, Error>> {
        .create { (single) -> Disposable in
            iTunesSearchAPI().callAPI(term: term, mediaType: mediaType) { data in
                single(.success(.success(data ?? [])))
            } errorHandler: { error in
                single(.success(.failure(APIResponseError.unreachable)))
            }
            return Disposables.create()
        }
    }
}

enum APIResponseError: Error {
    case JSONFormatUnexpectable
    case unreachable
}
