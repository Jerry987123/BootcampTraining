//
//  iTunesSearchAPI.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

//import AFNetworking
//

enum SearchingMediaType: String {
    case movie = "movie"
    case music = "music"
}
class iTunesSearchAPI {
    func callAPI(term:String, mediaType:SearchingMediaType, callback:@escaping(_ results:[iTunesSearchAPIResponseResult]?)->(), errorHandler:@escaping(_ error:Error?)->()){
        let url = "https://itunes.apple.com/search?term=\(term)&media=\(mediaType.rawValue)&country=TW"
        iTunesSearchAPIObj().callITunesAPI(url) { results in
            if let datas = results?.results {
                callback(datas)
            } else {
                callback(nil)
            }
        } errorHandler: { error in
            errorHandler(error)
        }
    }
}
