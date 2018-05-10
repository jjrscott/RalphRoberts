//
//  HeroViewController.swift
//  RalphRoberts
//
//  Created by John Scott on 10/05/2018.
//  Copyright © 2018 John Scott. All rights reserved.
//

import UIKit

class HeroViewController: UIViewController {
    
    public var character : MarvelConnector.Character?
    
    @IBOutlet weak var descriptionTextView: UITextView?
    @IBOutlet weak var imageView: UIImageView?
    
    var imageDataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = character?.name
        self.descriptionTextView?.text = character?.description
        
        if let image = character?.thumbnail
        {
            imageDataTask = MarvelConnector.getImage(image: image) { (image) in
                self.imageView?.image = image
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
