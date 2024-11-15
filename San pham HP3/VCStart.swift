//
//  ViewController.swift
//  San pham HP3
//
//  Created by Nguyễn Anh Kiệt on 15/11/24.
//

import UIKit

class VCStart: UIViewController {
    
    @IBAction func unwindToStart(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

