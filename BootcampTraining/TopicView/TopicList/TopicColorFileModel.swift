//
//  TopicModel.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/24.
//

struct TopicColor {
    var tabbar = UIColor()
}
struct TopicColorFileModel: Codable {
    var id = 0
    var tabbar = ColorRGB()
}
struct ColorRGB: Codable {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
}

