//
//  CustomError.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/30.
//

struct CustomError:Error {
    var desc = ""
    var localizedDescription: String {
        return desc
    }
    init(_ desc:String) {
        self.desc = desc
    }
}
