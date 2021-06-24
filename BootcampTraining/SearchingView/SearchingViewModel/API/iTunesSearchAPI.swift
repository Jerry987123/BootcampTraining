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
//    func callAPI(){
//        let url = "https://itunes.apple.com/search?term=iron+man&media=movie"
//        
//        let manager = AFHTTPSessionManager()
//        manager.get(url, parameters: nil, headers: nil, progress: nil) { task, response in
//            print("API success")
//            print(response)
//        } failure: { task, error in
//            print("API error")
//            print(error)
//        }
//
//    }
    func callAPI(term:String, mediaType:SearchingMediaType, handle:@escaping(_ results:[iTunesSearchAPIResponseResult]?)->()){
        let api = iTunesSearchAPIObj()
        let url = "https://itunes.apple.com/search?term=\(term)&media=\(mediaType.rawValue)"
        api.callITunesAPI(url) { results in
            if let datas = results as? [iTunesSearchAPIResponseResult] {
                handle(datas)
            } else {
                handle(nil)
            }
        }
    }
}
