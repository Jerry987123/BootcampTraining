//
//  TopicInteractor.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/24.
//


class TopicInteractor {
    
    static var topicColor = TopicColor()
    
    static func readTopicListFile() {
        var colorFile = [TopicColorFileModel]()
        guard let url = Bundle.main.url(forResource: "TopicList", withExtension: "json") else {
            return print("topicList file url failed to init.")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            colorFile = try decoder.decode([TopicColorFileModel].self, from: data)
        } catch {
            print("JSON decoder failed to decode.")
        }
        readColorModel(colorFile: colorFile)
    }
    static private func readColorModel(colorFile:[TopicColorFileModel]){
        let selectedTopic = TopicViewModel().getSelectedTopic()
        var topicColorFile = TopicColorFileModel()
        switch selectedTopic {
        case .deepColor:
            for file in colorFile {
                if file.id == 0 {
                    topicColorFile = file
                    break
                }
            }
        case .lightColor:
            for file in colorFile {
                if file.id == 1 {
                    topicColorFile = file
                    break
                }
            }
        }
        setTopicColor(topicColorFile: topicColorFile)
    }
    static private func setTopicColor(topicColorFile:TopicColorFileModel){
        var colorModel = TopicColor()
        colorModel.tabbar = UIColor(red: topicColorFile.tabbar.r/255, green: topicColorFile.tabbar.g/255, blue: topicColorFile.tabbar.b/255, alpha: 1.0)
        TopicInteractor.topicColor = colorModel
    }
}
