//
//  ViewController.swift
//  3DTouchFlashLight
//
//  Created by Harel Avikasis on 19/01/2016.
//  Copyright © 2016 Harel Avikasis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//    let captureSession = AVCaptureSession()
//    var captureDevice : AVCaptureDevice?
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    @IBOutlet weak var Slider: UISlider!
    
    @IBOutlet weak var valueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where traitCollection.forceTouchCapability == .Available {
            if (device.hasTorch) {
                let cgFloat1: CGFloat = touch.force
                let cgFloat2: CGFloat = touch.maximumPossibleForce
                let currentValue = Float(cgFloat1 / cgFloat2)
                do {
                    try device.lockForConfiguration()
                    if (device.torchMode == AVCaptureTorchMode.On) {
                        //                    device.torchMode = AVCaptureTorchMode.Off
                        if(currentValue <= 0.001) {
                            valueLabel.text = "\(0)"
                            device.torchMode = AVCaptureTorchMode.Off
                        } else if(currentValue >= 1.0){
                            try device.setTorchModeOnWithLevel(1.0)
                            valueLabel.text = "\(1.0)"
                        }else{
                            try device.setTorchModeOnWithLevel(currentValue)
                            valueLabel.text = "\(currentValue)"
                        }
                    } else {
                        if(currentValue <= 0.001) {
                            valueLabel.text = "\(0)"
                            device.torchMode = AVCaptureTorchMode.Off
                        } else if(currentValue >= 1.0){
                            try device.setTorchModeOnWithLevel(1.0)
                            valueLabel.text = "\(1.0)"
                        }else{
                            try device.setTorchModeOnWithLevel(currentValue)
                            valueLabel.text = "\(currentValue)"
                        }

                    }
                    device.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }

        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                    valueLabel.text = "\(0)"
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }

   
    @IBAction func valueChanged(sender: AnyObject) {
        let currentValue = Slider.value
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    if(currentValue == 0.001) {
                        valueLabel.text = "\(0)"
                        device.torchMode = AVCaptureTorchMode.Off
                    } else {
                        try device.setTorchModeOnWithLevel(currentValue)
                        valueLabel.text = "\(currentValue)"
                    }
                } else {
                    if(currentValue == 0.001) {
                        valueLabel.text = "\(0)"
                       device.torchMode = AVCaptureTorchMode.Off
                    } else {
                        try device.setTorchModeOnWithLevel(currentValue)
                        valueLabel.text = "\(currentValue)"
                    }
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        
    }

}

