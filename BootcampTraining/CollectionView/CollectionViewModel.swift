//
//  CollectionViewModel.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/25.
//

import RxCocoa

class CollectionViewModel {
    var movieDatas = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
    var musicDatas = BehaviorRelay(value: [iTunesSearchAPIResponseResult]())
}
