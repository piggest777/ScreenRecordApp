//
//  RecordVC.swift
//  ScreenRecordApp
//
//  Created by Denis Rakitin on 2019-10-08.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit
import ReplayKit

class RecordVC: UIViewController, RPPreviewViewControllerDelegate {
    
    @IBOutlet weak var starusLbl: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var micToggle: UISwitch!
    @IBOutlet weak var recordBtn: UIButton!
    
    var recoder = RPScreenRecorder.shared()
    private var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func imagePicked(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            selectedImageView.image = UIImage(named: "skate")!
        case 1:
                selectedImageView.image = UIImage(named: "food")!
        case 2:
                selectedImageView.image = UIImage(named: "cat")!
        case 3:
                selectedImageView.image = UIImage(named: "nature")!
        default:
            selectedImageView.image = UIImage(named: "skate")!
        }
        
    }
    
    
    @IBAction func recordBtnPressed(_ sender: Any) {
        if !isRecording {
            startRecording()
        } else {
            stopRecording()
        }
    }
    
    func startRecording () {
        guard recoder.isAvailable else {
            print("Recording is not availibale now")
            return
        }
        
        
        if micToggle.isOn {
            recoder.isMicrophoneEnabled = true
        } else {
            recoder.isMicrophoneEnabled = false
        }
        
        recoder.startRecording { (error) in
            guard error == nil else {
                print("there was en error starting the recoder", error)
                return
            }
           
            
            print("Recording succesfully")
            DispatchQueue.main.async {
                self.micToggle.isEnabled = false
                self.recordBtn.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
                self.recordBtn.setTitle("Stop", for: .normal)
                self.starusLbl.text = "Recording..."
                self.starusLbl.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                self.isRecording = true
            }

        }
        
    }
    
    func stopRecording () {
        print(recoder.isRecording)
        recoder.stopRecording { (preview, error) in
            guard preview != nil else {
                print("Preview conntroller is not available")
                return
            }
            
//            preview?.editButtonItem.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            
            
            let alert = UIAlertController(title: "Recording finnished", message: "Would you like edit or delete you recording?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.recoder.discardRecording {
                    print("Recording succesfuly discarded")
                }
            }
            let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
                preview?.previewControllerDelegate = self
                self.present(preview!, animated: true, completion: nil)
                
            }
            
            alert.addAction(deleteAction)
            alert.addAction(editAction)
            self.present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.async {
                self.viewReset()
                self.isRecording = false
            }
            
        }
    }
    
    func viewReset () {
        
        self.micToggle.isEnabled = true
        self.recordBtn.setTitleColor(#colorLiteral(red: 0.3017679751, green: 0.746871829, blue: 0.3396928906, alpha: 1), for: .normal)
        self.recordBtn.setTitle("Start", for: .normal)
        self.starusLbl.text = "Ready to record"
        self.starusLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

