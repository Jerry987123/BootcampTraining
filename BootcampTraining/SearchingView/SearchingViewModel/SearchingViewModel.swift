//
//  SearchingViewModel.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import RxCocoa

class SearchingViewModel {
    var movieDatas = BehaviorRelay(value: [iTunesSearchAPIResponseResult()])
    var musicDatas = BehaviorRelay(value: [MusicModel()])
    
    func updatedByAPI(){
        iTunesSearchAPI().callAPI { datas in
            if let datas = datas {
                self.movieDatas.accept(datas)
            }
        }
        // TODO 測試用資料
        let tempoMusicDatas = [MusicModel()]
        musicDatas.accept(tempoMusicDatas)
    }
}
