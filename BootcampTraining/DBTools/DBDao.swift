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
        filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            + "/" + fileName
        
        print("filePath: \(filePath)")
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    /// 生成 .sqlite 檔案並創建表格，只有在 .sqlite 不存在時才會建立
    func createTable() {
        let fileManager: FileManager = FileManager.default
        
        // 判斷documents是否已存在該檔案
        if !fileManager.fileExists(atPath: filePath) {
            
            // 開啟連線
            if openConnection() {
                let createTableSQL = """
                    CREATE TABLE \(tableName) (
                    TrackId integer  NOT NULL  PRIMARY KEY,
                    MediaType Text,
                    TrackName Text,
                    ArtistName Text,
                    CollectionName Text,
                    TrackTimeMillis Integer,
                    LongDescription Text,
                    ArtworkUrl100 Text,
                    TrackViewUrl Text)
                """
                database.executeStatements(createTableSQL)
                print("file copy to: \(filePath)")
            }
        } else {
            print("DID-NOT copy db file, file allready exists at path:\(filePath)")
        }
    }
    
    /// 取得 .sqlite 連線
    ///
    /// - Returns: Bool
    func openConnection() -> Bool {
        var isOpen: Bool = false
        
        database = FMDatabase(path: filePath)
        
        if database != nil {
            if database.open() {
                isOpen = true
            } else {
                print("Could not get the connection.")
            }
        }
        
        return isOpen
    }
    func insertData(mediaType: SearchingMediaType, model: iTunesSearchAPIResponseResult) -> Result<Bool, CustomError> {
        var result = Result<Bool, CustomError>.success(true)
        if openConnection() {
            let insertSQL: String =
                "INSERT INTO \(tableName) "
                + "(mediaType, trackName, artistName, collectionName, trackTimeMillis, longDescription, artworkUrl100, trackViewUrl, trackId) "
                + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)"
            if !database.executeUpdate(insertSQL,
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
                let msg = database.lastErrorMessage()
                result = .failure(CustomError(msg))
            }
            database.close()
        }
        return result
    }
    func queryData(condition:String?) -> Result<[CollectionDBModel], CustomError> {
        var result = Result<[CollectionDBModel], CustomError>.success([])
        var models: [CollectionDBModel] = [CollectionDBModel]()
        
        if openConnection() {
            var querySQL: String = "SELECT * FROM \(tableName)"
            if let condition = condition {
                querySQL += " where \(condition)"
            }
            
            do {
                let dataLists: FMResultSet = try database.executeQuery(querySQL, values: nil)
                
                while dataLists.next() {
                    let model = CollectionDBModel()
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
                result = .success(models)
            } catch {
                let msg = error.localizedDescription
                let error = CustomError(msg)
                result = .failure(error)
            }
        }
        
        return result
    }
    func queryDataCount() -> Result<Int, CustomError> {
        var result = Result<Int, CustomError>.success(0)
        if openConnection() {
            let querySQL: String = "SELECT Count(*) FROM \(tableName)"
            do {
                let dataLists: FMResultSet = try database.executeQuery(querySQL, values: nil)
                
                while dataLists.next() {
                    let count = Int(dataLists.int(forColumn: "Count(*)"))
                    result = .success(count)
                }
            } catch {
                let msg = error.localizedDescription
                let error = CustomError(msg)
                result = .failure(error)
            }
        }
        
        return result
    }
    func deleteData(trackId: Int) -> Result<Bool, CustomError> {
        var result = Result<Bool, CustomError>.success(true)
        if openConnection() {
            let deleteSQL: String = "DELETE FROM \(tableName) WHERE trackId = ?"
            
            do {
                try database.executeUpdate(deleteSQL, values: [trackId])
            } catch {
                let msg = error.localizedDescription
                result = .failure(CustomError(msg))
            }
            database.close()
        }
        return result
    }
}
