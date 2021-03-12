//
//  TableViewController.swift
//  pate0910_a6
//
//  Created by Prism Student on 2020-04-04.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var rssItems: [RSSItem]?
    let urlPath: String = "https://globalnews.ca/toronto/feed/"
    var rowHeight = CGFloat(150.0)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        tableView.estimatedRowHeight = rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        fetchData() // get xml data
        activityIndicator.stopAnimating()
    }

    func fetchData(){
        let feedParser = FeedParser()
        feedParser.parseFeed(url: urlPath) {
                (rssItems) in
            self.rssItems = rssItems
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .right)
                }
            }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rssItems = rssItems else {
            return 0 // no data found for rows
        }
        return rssItems.count // rows exist
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if let item = rssItems?[indexPath.item] {
            cell.item = item
        }
        return cell
    }
    
    //go to detail view on touch
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = SharingNewsCollection()
        SharingNewsCollection.sharedNewsCollection.newsCollection = NewsCollection()
        let theSharedCollection = SharingNewsCollection.sharedNewsCollection.newsCollection
        theSharedCollection?.setCurrentIndex(to: indexPath.row) // set index to tapped news cell
        performSegue(withIdentifier: "newsDetailView", sender: self)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
}
