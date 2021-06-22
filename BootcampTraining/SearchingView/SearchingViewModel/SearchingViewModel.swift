//
//  SearchingViewModel.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import RxCocoa

class SearchingViewModel {
    var movieDatas = BehaviorRelay(value: [MovieModel()])
    var musicDatas = BehaviorRelay(value: [MusicModel()])
    
    func updatedByAPI(){
        // TODO 測試用資料
        let tempoMovieDatas = [MovieModel()]
        let tempoMusicDatas = [MusicModel()]
        movieDatas.accept(tempoMovieDatas)
        musicDatas.accept(tempoMusicDatas)
    }
}
