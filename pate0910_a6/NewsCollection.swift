//
//  NewsCollection.swift
//  pate0910_a4
//
//  Created by Prism Student on 2020-02-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//
import Foundation
import UIKit
class NewsCollection: NSObject, NSCoding {
    static var collection = [News]() // a collection is an array of news
    static var current:Int = 0 // the current news in the collection (to be shown in thescene)

    let collectionKey = "collectionKey"
    let currentKey = "currentKey"

    // MARK: - NSCoding methods
    override init(){
        super.init()
        //setup()
    }
    
    //add function
    func add(newsLink: String, newsImage: UIImage, newsTitle: String, newsDescription: String){
        let news = News(newsLink: newsLink, newsImage: newsImage, newsTitle: newsTitle, newsDescription: newsDescription)
        NewsCollection.collection.append(news!)
    }
    
    //getter functions
    func getLink() -> String{
        let news = NewsCollection.collection[NewsCollection.current]
        return news.newsLink
    }
    func getImage() -> UIImage{
        let news = NewsCollection.collection[NewsCollection.current]
        return news.newsImage
    }
    func getTitle() -> String{
        let news = NewsCollection.collection[NewsCollection.current]
        return news.newsTitle
    }
    func getDescription() -> String{
          let news = NewsCollection.collection[NewsCollection.current]
          return news.newsDescription
    }
    func getCurrentIndex() -> Int {
        return NewsCollection.current
    }
    func getCurrentNews() -> News {
        let news = NewsCollection.collection[NewsCollection.current]
        return news
    }
    
    //setter functions
    func setCurrentIndex(to index: Int){
        NewsCollection.current = index
    }

    required convenience init?(coder decoder: NSCoder) {
        self.init()
        NewsCollection.collection = (decoder.decodeObject(forKey: collectionKey) as? [News])!
        NewsCollection.current = (decoder.decodeInteger(forKey: currentKey))
 }

    func encode(with acoder: NSCoder) {
        acoder.encode(NewsCollection.collection, forKey: collectionKey)
        acoder.encode(NewsCollection.current, forKey: currentKey)
 }
 // Mark: - Helpers
}
