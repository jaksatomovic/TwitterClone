//
//  ResetVC.swift
//  Twitter
//
//  Created by MacBook Pro on 11.06.16.
//  Copyright © 2016 Akhmed Idigov. All rights reserved.
//

import UIKit

class ResetVC: UIViewController {
    
    // UI obj
    @IBOutlet var emailTxt: UITextField!
    
    
    // first func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // reset button clicked
    @IBAction func reset_click(_ sender: AnyObject) {
        
        // if not text entered
        if emailTxt.text!.isEmpty {
            
            // red placeholder
            emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:UIColor.red])
        
        // if text is enetered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            // shortcut ref to text in email TextField
            let email = emailTxt.text!.lowercased()
            
            // send mysql / php / hosting request
            
            // url path to php file
            let url = URL(string: "http://localhost/Twitter/resetPassword.php")!
            
            // request to send to this file
            var request = URLRequest(url: url)
            
            // method of passing inf to this file
            request.httpMethod = "POST"
            
            // body to be appended to url. It passes inf to this file
            let body = "email=\(email)"
            request.httpBody = body.data(using: .utf8)
            
            // proces reqeust
            URLSession.shared.dataTask(with: request) { data, response, error in

                if error == nil {
                    
                    // give main queue to UI to communicate back
                    DispatchQueue.main.async(execute: { 
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            let email = parseJSON["email"]
                            
                            // successfully reset
                            if email != nil {
                                
                                // get main queue to communicate back to user
                                DispatchQueue.main.async(execute: {
                                    let message = parseJSON["message"] as! String
                                    appDelegate.infoView(message: message, color: colorLightGreen)
                                    
                                })
                            
                            // error
                            } else {
                                
                                // get main queue to communicate back to user
                                DispatchQueue.main.async(execute: {
                                    let message = parseJSON["message"] as! String
                                    appDelegate.infoView(message: message, color: colorSmoothRed)
                                    
                                })
                                return

                            }
                            
                            
                        } catch {

                            // get main queue to communicate back to user
                            DispatchQueue.main.async(execute: {
                                let message = "\(error)"
                                appDelegate.infoView(message: message, color: colorSmoothRed)
                            })
                            return

                        }
                        
                    })
                    
                    
                } else {

                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: {
                        let message = error!.localizedDescription
                        appDelegate.infoView(message: message, color: colorSmoothRed)
                    })
                    return

                }
                
            }.resume()
            
        }
        
    }
    
    
    // white status bar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    // touched screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // hide keyboard
        self.view.endEditing(false)
    }

    
}



