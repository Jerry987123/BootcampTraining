//
//  iTunesSearchAPI.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

//import AFNetworking
//
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
    func callAPI(){
        let api = iTunesSearchAPIObj()
        let url = "https://itunes.apple.com/search?term=iron+man&media=movie"
        api.callITunesAPI(url)
    }
}
