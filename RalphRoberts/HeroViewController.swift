//
//  HeroViewController.swift
//  RalphRoberts
//
//  Created by John Scott on 10/05/2018.
//  Copyright © 2018 John Scott. All rights reserved.
//

import UIKit

class HeroViewController: UIViewController {
    
    public var character : MarvelConnector.Character? {
        didSet {
            reloadData()
        }
    }
    
    @IBOutlet weak var descriptionTextView: UITextView?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var backgroundImageView: UIImageView?

    var imageDataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    func reloadData()
    {
        self.title = character?.name
        
        if let description = character?.description, description != ""
        {
            self.descriptionTextView?.text = description
        }
        else if let name = character?.name, name != ""
        {
            self.descriptionTextView?.text = "\(name) prefers to be mysterious."
        }
        else
        {
            self.descriptionTextView?.text = "This hero is so secretive that not even their name is known."
        }
        
        
        if let image = character?.thumbnail
        {
            imageDataTask = MarvelConnector.getImage(image: image) { (image) in
                self.imageView?.image = image
                self.backgroundImageView?.image = image
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageDataTask?.cancel()
    }
}
