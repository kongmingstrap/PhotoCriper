//
//  ViewController.swift
//  PhotoCriper
//
//  Created by tanaka.takaaki on 2017/03/07.
//  Copyright © 2017年 tanaka.takaaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tapedEditButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "PhotoCrip", sender: nil)
    }
}

