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
    func timeFromMillisToHMMSS(time:Int) -> String {
        let duration = TimeInterval(time/1000)
        if duration == 0 {
            return ""
        } else if duration < 60 {
            return Tools().makeSecondToTimeFormatterWithLeadingZero(duration: duration)
        } else {
            return Tools().makeSecondToTimeFormatter(duration: duration)
        }
    }
    func makeSecondToTimeFormatter(duration:TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.dropLeading]
        let formatteredDuration = formatter.string(from: duration)
        return formatteredDuration ?? ""
    }
    func makeSecondToTimeFormatterWithLeadingZero(duration:TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        let formatteredDuration = formatter.string(from: duration)
        if var formatteredDuration = formatteredDuration, formatteredDuration.first == "0" {
            formatteredDuration.removeFirst()
            return String(formatteredDuration)
        }
        return formatteredDuration ?? ""
    }
}
