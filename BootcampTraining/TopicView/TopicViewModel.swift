//
//  TopicViewModel.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/24.
//

enum TopicType:Int {
    case deepColor
    case lightColor
}

class TopicViewModel {
    let themes = ["深色主題", "淺色主題"]
    let TOPIC_KEY = "TOPIC_KEY"
    
    func getSelectedTopic() -> TopicType {
        let result = UserDefaults.standard.integer(forKey: TOPIC_KEY)
        return TopicType(rawValue: result) ?? .deepColor
    }
    func setSelectedTopic(topicType:TopicType){
        UserDefaults.standard.set(topicType.rawValue, forKey: TOPIC_KEY)
    }
}
