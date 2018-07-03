//
//  DBManager.swift
//  FMDB_Demo
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FMDB


class DBManager: NSObject {

    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "database.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
}
