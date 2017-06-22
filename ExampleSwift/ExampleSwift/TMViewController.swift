//
//  ViewController.swift
//  ExampleSwift
//
//  Created by C4Q on 6/22/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import Spectacles

class TMViewController: UIViewController {
    
    var label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center

        return view
    }()
    
    override func viewDidLoad() {
        let jsonURL = Bundle.main.url(forResource: "Spectacles.podspec", withExtension: ".json")
        let spec = TMPodspec(fileURL: jsonURL)!
        
        self.label.text = NSString(format: "This sample uses %@ version %@ (%@), learn more at %@",
                                 spec.name, spec.version, spec.summary, spec.homepageURL! as CVarArg) as String
            
        self.view.addSubview(label)
        
    }
    
    override func viewWillLayoutSubviews() {
        self.label.frame = self.view.bounds
    }
}

