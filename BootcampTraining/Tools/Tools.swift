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
    func numberCurrency(count:Int) -> String {
        let number = NSNumber(value: count)
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.currencySymbol = ""
        nf.maximumFractionDigits = 0
        return nf.string(from: number) ?? String(describing: count)
    }
}
