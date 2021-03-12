//
//  XMLParser.swift
//  pate0910_a6
//
//  Created by Prism Student on 2020-04-04.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import UIKit

struct RSSItem{
    var title: String
    var description: String
    var newsLink: String
    var newsImageLink: String
    var newsImage: UIImage!
}

class FeedParser: NSObject, XMLParserDelegate{
    // variables to hold xml items and help read
    private var rssItems: [RSSItem] = [] // will store the items from feed
    private var currentElement = ""
    private var currentParsedElement = ""
    private var inside = false;
    private var currentTitle: String = ""{
        // when set do some cleaning to remove spaces
        didSet{
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription: String = ""{
        // when set do some cleaning to remove spaces
        didSet{
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentLink: String = ""{
        // when set do some cleaning to remove spaces
        didSet{
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentImage: UIImage!
    private var currentImageLink: String = ""{
        // when set do some cleaning to remove spaces
        didSet{
            currentImageLink = currentImageLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var parserCompletionHandler: (([RSSItem])-> Void)? // return void when done reading element

    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?){
        self.parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data,response,error) in guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
                }
                //parse
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
        }
            task.resume()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item"{
            inside = true
        }
        if inside{
            switch elementName{
                case "title":
                    currentElement = elementName
                    currentTitle = ""
                case "description":
                    currentElement = elementName
                    currentDescription = ""
                case "enclosure":
                    currentElement = elementName
                    currentImageLink = attributeDict["url"]!
                case "guid":
                    currentElement = elementName
                    currentLink = ""
                default:
                    break
            }
        }
    }
    
    // get info from xml tag char by char
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string //since string is char it will get appended to make full string
        case "description": currentDescription += string
        case "guid": currentLink += string
        case "enclosure": currentImageLink += string
        default: break
        }
    }

    // parser reached closing tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            // image link has been obtained so need to download
            // download image with code from assignment
            if currentImageLink != ""{
                let url = NSURL(string: currentImageLink)
                // error free url
                if url != nil {
                    //print(url)
                    let imageData = NSData(contentsOf: url! as URL)
                    currentImage = UIImage(data: imageData! as Data) // get our image
                }
                else{
                    currentImage = UIImage(named: "gnews.png")! //default image
                }
            }
            // set the info for news cell to read
            let rssItem = RSSItem(title: currentTitle,description: currentDescription, newsLink: currentLink, newsImageLink: currentImageLink, newsImage: currentImage)
            self.rssItems.append(rssItem)
            // save news cell data into collection
            _ = SharingNewsCollection()
            SharingNewsCollection.sharedNewsCollection.newsCollection = NewsCollection()
            let theSharedCollection = SharingNewsCollection.sharedNewsCollection.newsCollection
            theSharedCollection?.add(newsLink: currentLink, newsImage: currentImage, newsTitle: currentTitle, newsDescription: currentDescription)
        }
    }
    
    // end of doc
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    //error handle
    func parser(_ parser: XMLParser, parseErrorOccured parserError: Error){
        print(parserError.localizedDescription)
    }
}
