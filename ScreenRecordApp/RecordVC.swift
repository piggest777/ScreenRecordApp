//
//  RecordVC.swift
//  ScreenRecordApp
//
//  Created by Denis Rakitin on 2019-10-08.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit
import ReplayKit

class RecordVC: UIViewController {
    
    @IBOutlet weak var starusLbl: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var micToggle: UISwitch!
    @IBOutlet weak var recordBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func imagePicked(_ sender: UISegmentedControl) {
    }
    
    
    @IBAction func recordBtnPressed(_ sender: Any) {
    }
    
}

