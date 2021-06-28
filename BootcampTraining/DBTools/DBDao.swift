//
//  DBDao.swift
//  BootcampTraining
//
//  Created by Jayyi on 2021/6/28.
//

import UIKit
import FMDB

class DBDao: NSObject {
    
    static let shared = DBDao()
    
    let tableName = "Collection"
    
    var fileName: String = "DB.sqlite" // sqlite name
    var filePath: String = "" // sqlite path
    var database: FMDatabase! // FMDBConnection
    
    private override init() {
        super.init()
        
        // 取得sqlite在documents下的路徑(開啟連線用)
        self.filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            + "/" + self.fileName
        
        print("filePath: \(self.filePath)")
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    /// 生成 .sqlite 檔案並創建表格，只有在 .sqlite 不存在時才會建立
    func createTable() {
        let fileManager: FileManager = FileManager.default
        
        // 判斷documents是否已存在該檔案
        if !fileManager.fileExists(atPath: self.filePath) {
            
            // 開啟連線
            if self.openConnection() {
                let createTableSQL = """
                    CREATE TABLE \(tableName) (
                    ID integer  NOT NULL  PRIMARY KEY autoincrement,
                    MediaType Text,
                    TrackName Text,
                    ArtistName Text,
                    CollectionName Text,
                    TrackTimeMillis Integer,
                    LongDescription Text,
                    ArtworkUrl100 Text,
                    TrackViewUrl Text,
                    TrackId Integer)
                """
                self.database.executeStatements(createTableSQL)
                print("file copy to: \(self.filePath)")
            }
        } else {
            print("DID-NOT copy db file, file allready exists at path:\(self.filePath)")
        }
    }
    
    /// 取得 .sqlite 連線
    ///
    /// - Returns: Bool
    func openConnection() -> Bool {
        var isOpen: Bool = false
        
        self.database = FMDatabase(path: self.filePath)
        
        if self.database != nil {
            if self.database.open() {
                isOpen = true
            } else {
                print("Could not get the connection.")
            }
        }
        
        return isOpen
    }
    func insertData(mediaType: SearchingMediaType, model: iTunesSearchAPIResponseResult) {
        if self.openConnection() {
            let insertSQL: String =
                "INSERT INTO \(tableName) "
                + "(mediaType, trackName, artistName, collectionName, trackTimeMillis, longDescription, artworkUrl100, trackViewUrl, trackId) "
                + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)"
            if !self.database.executeUpdate(insertSQL,
                                            withArgumentsIn:
                                                [mediaType.rawValue,
                                                 model.trackName ?? NSNull(),
                                                 model.artistName ?? NSNull(),
                                                 model.collectionName ?? NSNull(),
                                                 model.trackTimeMillis ?? NSNull(),
                                                 model.longDescription ?? NSNull(),
                                                 model.artworkUrl100 ?? NSNull(),
                                                 model.trackViewUrl ?? NSNull(),
                                                 model.trackId ?? NSNull()]) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            
            self.database.close()
        }
    }
    func queryData(condition:String?) -> [CollectionDBModel] {
        var models: [CollectionDBModel] = [CollectionDBModel]()
        
        if self.openConnection() {
            var querySQL: String = "SELECT * FROM \(tableName)"
            if let condition = condition {
                querySQL += " where \(condition)"
            }
            
            do {
                let dataLists: FMResultSet = try database.executeQuery(querySQL, values: nil)
                
                while dataLists.next() {
                    let model = CollectionDBModel()
                    model.id = Int(dataLists.int(forColumn: "ID"))
                    model.mediaType = dataLists.string(forColumn: "mediaType") ?? ""
                    model.trackName = dataLists.string(forColumn: "trackName")
                    model.artistName = dataLists.string(forColumn: "artistName")
                    model.collectionName = dataLists.string(forColumn: "collectionName")
                    model.trackTimeMillis = NSNumber(value: dataLists.int(forColumn: "trackTimeMillis"))
                    model.longDescription = dataLists.string(forColumn: "longDescription")
                    model.artworkUrl100 = dataLists.string(forColumn: "artworkUrl100")
                    model.trackViewUrl = dataLists.string(forColumn: "trackViewUrl")
                    model.trackId = NSNumber(value: dataLists.int(forColumn: "trackId"))
                    models.append(model)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return models
    }
    func deleteData(trackId: Int) {
        if self.openConnection() {
            let deleteSQL: String = "DELETE FROM \(tableName) WHERE trackId = ?"
            
            do {
                try self.database.executeUpdate(deleteSQL, values: [trackId])
            } catch {
                print(error.localizedDescription)
            }
            
            self.database.close()
        }
    }
}
