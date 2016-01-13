//
//  NRCourceViewController.swift
//  IVORY
//
//  Created by Shayin Feng on 1/12/16.
//  Copyright © 2016 ZengJintao. All rights reserved.
//

import UIKit

class NRCourseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
}
