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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = character?.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
