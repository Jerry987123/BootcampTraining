//
//  CustomError.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/7/2.
//

struct CustomError:Error {
    var desc = ""
    var localizedDescription: String {
        return desc
    }
    init(_ msg:String) {
        desc = msg
    }
}
