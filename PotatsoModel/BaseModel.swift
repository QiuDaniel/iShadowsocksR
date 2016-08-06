//
//  BaseModel.swift
//  Potatso
//
//  Created by LEI on 4/6/16.
//  Copyright © 2016 TouchingApp. All rights reserved.
//

import RealmSwift
import PotatsoBase
import CloudKit

private let version: UInt64 = 13
public var defaultRealm = try! Realm()

public func setupDefaultReaml() {
    var config = Realm.Configuration()
//    #if DEBUG
    let path = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString).stringByAppendingPathComponent("./potatso.realm")
    let sharedURL = NSURL(string: path)!
//    #else
//    let sharedURL = Potatso.sharedDatabaseUrl()
//    #endif
    if let originPath = config.fileURL?.path {
        if NSFileManager.defaultManager().fileExistsAtPath(originPath) {
            _ = try? NSFileManager.defaultManager().moveItemAtPath(originPath, toPath: sharedURL.path!)
        }
    }
    config.fileURL = sharedURL
    config.schemaVersion = version
    config.migrationBlock = { migration, oldSchemaVersion in
        // 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
        if (oldSchemaVersion < version) {
            // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
        }
    }
    Realm.Configuration.defaultConfiguration = config
}


public class BaseModel: Object {
    public dynamic var uuid = NSUUID().UUIDString
    public dynamic var createAt = NSDate().timeIntervalSince1970
    public dynamic var updatedAt = NSDate().timeIntervalSince1970
    public dynamic var deleted = false
    public dynamic var synced = false

    override public static func primaryKey() -> String? {
        return "uuid"
    }
    
    static var dateFormatter: NSDateFormatter {
        let f = NSDateFormatter()
        f.dateFormat = "MM-dd HH:mm:ss"
        return f
    }

    public func validate(inRealm realm: Realm) throws {
        //
    }

}

// API
extension Results {

    public func delete() throws {
        defaultRealm.beginWrite()
        for object in self {
            if let m = object as? BaseModel {
                m.deleted = true
            }
        }
        try defaultRealm.commitWrite()
    }

}
