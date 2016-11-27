//
//  EventPhotoDetailsViewController.swift
//  MobileLevel1
//
//  Created by Daniel Avram on 27/11/2016.
//  Copyright © 2016 Daniel Avram. All rights reserved.
//

import UIKit

class EventPhotoDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Instance.instance.eventDetailsIndex > -1) {
            self.label.text = Instance.instance.eventDetails[Instance.instance.eventDetailsIndex].description
            self.imageView.image = UIImage(named: "codebehind square negative")
            self.imageView.af_setImage(withURL: URL(string: Instance.instance.eventDetails[Instance.instance.eventDetailsIndex].imageUrl)! )
            print(label.text)
            print(imageView.image)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
