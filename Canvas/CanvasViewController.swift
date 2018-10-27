//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Hamsika Pongubala on 10/26/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

  @IBOutlet weak var trayView: UIView!
  
  var trayOriginalCenter: CGPoint!
  var trayDownOffset: CGFloat!
  var trayUp: CGPoint!
  var trayDown: CGPoint!

  var newlyCreatedFace: UIImageView!
  var newlyCreatedFaceOriginalCenter: CGPoint!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 160
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    
         // newlyCreatedFace.isUserInteractionEnabled = true
    }
    

  @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
  
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
    
        if sender.state == .began {
            print("Gesture began")
            trayOriginalCenter = trayView.center

        } else if sender.state == .changed {
            print("Gesture is changing")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
          
        } else if sender.state == .ended {
            print("Gesture ended")
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayDown
                }
                //self.trayView.center = self.trayDown
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayUp
                }
                //self.trayView.center = self.trayUp
            }
        }
    
    
  }
 
 
  @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
    
    let translation = sender.translation(in: view)
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(facePan(_: )))
    
    if sender.state == .began {
            print("Gesture began")
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
      
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
      
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
      
        }
        else if sender.state == .changed {
            print("Gesture is changing")
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
      
        }
        else if sender.state == .ended {
      
      
            print("Gesture ended")
        }
    
  }
  
 @objc func facePan(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
  
        if sender.state == .began {
            print("Gesture began")
            newlyCreatedFace = sender.view as? UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        }
        else if sender.state == .changed {
          
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
          
            print("Gesture ended")
        }
    }
 @objc func didTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
    }
 
 
}
