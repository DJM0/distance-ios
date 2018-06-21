//
//  ViewController.swift
//  Distance
//
//  Created by David Maitland on 05/06/2018.
//  Copyright © 2018 David Maitland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UILabelTotal: UILabel!
    
    @IBAction func ButtonRefresh(_ sender: Any) {
        getData(completionHandler: updateView)
    }
    
    func updateView(total: Double?) {
        
        let rounded = Int(total!.rounded())
        let display = "\(rounded)"
        self.UILabelTotal.text = display
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup label
        
        self.UILabelTotal.text = "0"
        self.UILabelTotal.layer.masksToBounds = true
        self.UILabelTotal.layer.cornerRadius = 5
        
        // ToDo: Move this out of the view, do I need to?
        
        getData(completionHandler: updateView)
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

