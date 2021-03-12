//
//  DetailViewController.swift
//  pate0910_a6
//
//  Created by Prism Student on 2020-04-04.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var scaleRatio = CGFloat(0) // scale ratio
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsInfo: UITextView!
    
    override func viewDidLoad() {
        //refresh()
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scaleImage() // scale the view frame for image to be of required ratio
        addImgClick()
        refresh()
    }
    
    /*
     function to add click functionality on image by programmatically adding clickable subview
     */
    func addImgClick(){
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tap)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
    /*
     function to scale image from requirement
     */
    func scaleImage(){
        let screenSize: CGRect = imageView.bounds
        let height = screenSize.height // 1/5 of the screen size
        scaleRatio = 460/259 // scale ratio from assignment requirement
        let width = height*scaleRatio
        let yoffset = (screenSize.height/2) - (height/2)
        let xoffset = (screenSize.width/2) - (width/2)
        newsImage.frame = CGRect(x: xoffset, y: yoffset, width: width , height: height) // ratio of image is always 460/259
    }

    /*
     what ever the current collection is, this function will get the current data
     */
    func refresh(){
        _ = SharingNewsCollection()
        SharingNewsCollection.sharedNewsCollection.newsCollection = NewsCollection()
        let theSharedCollection = SharingNewsCollection.sharedNewsCollection.newsCollection
        
        if (NewsCollection.collection.count == 0){
            clear()
        }
        else{
            let initialImage = theSharedCollection?.getImage()
            newsImage.image = initialImage
            newsInfo.text = theSharedCollection?.getDescription()
            // change navbar title
            navigationBar.title = theSharedCollection?.getTitle()
        }
    }
    func clear(){
        newsImage.image = UIImage(named: "gnews")
        newsInfo.text = ""
    }
    
    /*
     function when image is tapped to open view for webpages
     */
    @objc func imageTapped(recognizer: UITapGestureRecognizer){
        //print("clicked")
        performSegue(withIdentifier: "linkClicked", sender: self)
    }
}

