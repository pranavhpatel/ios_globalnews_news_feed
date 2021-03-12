//
//  Fruit.swift
//  pate0910_a6
//
//  Created by Prism Student on 2020-02-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import UIKit
import os.log
    class News: NSObject, NSCoding {
        let newsImage : UIImage
        let newsLink : String
        var newsTitle : String
        var newsDescription : String
 
        struct PropertyKey {
            static let newsImage = "newsImage"
            static let newsLink = "newsLink"
            static let newsTitle = "newsTitle"
            static let newsDescription = "newsDescription"
        }
        func encode(with aCoder: NSCoder) {
            aCoder.encode(newsLink, forKey: PropertyKey.newsLink)
            aCoder.encode(newsImage, forKey: PropertyKey.newsImage)
            aCoder.encode(newsTitle, forKey: PropertyKey.newsTitle)
            aCoder.encode(newsDescription, forKey: PropertyKey.newsDescription)
        }
        
        required convenience init?(coder aDecoder: NSCoder) {
            // The name is required. If we cannot decode a name string, the initializer should fail.
            guard let linkDecoded = aDecoder.decodeObject(
                forKey: PropertyKey.newsLink) as? String else {
                    os_log("Unable to decode the name for link.",
                        log: OSLog.default, type: .debug)
                    return nil
            }
            guard let titleDecoded = aDecoder.decodeObject(
                forKey: PropertyKey.newsTitle) as? String else {
                    os_log("Unable to decode the name for title.",
                        log: OSLog.default, type: .debug)
                    return nil
            }
            guard let descriptionDecoded = aDecoder.decodeObject(
                forKey: PropertyKey.newsDescription) as? String else {
                    os_log("Unable to decode the name for description.",
                        log: OSLog.default, type: .debug)
                    return nil
            }
            // Because photo is an optional property of Meal, just use conditional cast.
        let imageDecoded = (aDecoder.decodeObject(forKey: PropertyKey.newsImage) as? UIImage)!
            // Must call designated initializer.
        self.init(newsLink: linkDecoded, newsImage: imageDecoded , newsTitle: titleDecoded , newsDescription: descriptionDecoded)
        }
    
        init?(newsLink: String, newsImage: UIImage, newsTitle: String, newsDescription: String) {
            self.newsLink = newsLink
            self.newsImage = newsImage
            self.newsTitle = newsTitle
            self.newsDescription = newsDescription
        } //init?
}
