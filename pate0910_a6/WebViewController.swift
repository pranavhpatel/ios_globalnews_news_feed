//
//  WebViewController.swift
//  pate0910_a6
//
//  Created by Prism Student on 2020-04-04.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    @IBOutlet weak var webpage: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = SharingNewsCollection()
        SharingNewsCollection.sharedNewsCollection.newsCollection = NewsCollection()
        let theSharedCollection = SharingNewsCollection.sharedNewsCollection.newsCollection
        var link = theSharedCollection?.getLink()
        link = link?.replacingOccurrences(of: "http://shawglobalnews.wordpress.com", with: "https://globalnews.ca")
        //print(link)
        let url = URL(string: (link ?? "https://globalnews.ca/")!)!
        let request = URLRequest(url: url)
        webpage.load(request)
        
        //navigation code
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "News Feed", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    @objc func back(sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "goNewsFeed", sender: self)
        
    }
    
    @IBAction func backClick(_ sender: Any) {
    }
    
    @IBAction func nextClick(_ sender: Any) {
    }
}
