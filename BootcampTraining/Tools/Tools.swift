//
//  Tools.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import Foundation

class Tools {
    func make0To00(number:Int) -> String {
        let numberString = String(describing: number)
        if numberString.count == 1 {
            return "0\(numberString)"
        } else {
            return numberString
        }
    }
}
