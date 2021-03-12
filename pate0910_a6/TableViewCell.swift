//
//  TableViewCell.swift
//  pate0910_a6
//
//  Created by Prism Student on 2020-04-04.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell{
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle:UILabel!
    
    var item: RSSItem! {
        didSet {
            newsTitle.text = item.title
            newsImage.image = item.newsImage
        }
    }
}
