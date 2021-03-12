//
//  SharingNewsCollection.swift
//  pate0910_a6
//
//  Created by Prism Student on 2020-02-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation

class SharingNewsCollection {
    static let sharedNewsCollection = SharingNewsCollection()
    let fileName = "A6news.archive"
    private let rootKey = "rootKey"
    var newsCollection : NewsCollection?
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(
 
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        return documentsDirectory.appendingPathComponent(fileName) as String
    }
    func loadNewsCollection(){
        print("loadNewsCollection  ...starting")
        let filePath = self.dataFilePath()
        if (FileManager.default.fileExists(atPath: filePath)) { let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            SharingNewsCollection.sharedNewsCollection.newsCollection = unarchiver.decodeObject(forKey: rootKey) as? NewsCollection
            unarchiver.finishDecoding()
        }
    }
    func saveNewsCollection(){
        let filePath = self.dataFilePath()
        print("saving the data")
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SharingNewsCollection.sharedNewsCollection.newsCollection, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
} //Class
