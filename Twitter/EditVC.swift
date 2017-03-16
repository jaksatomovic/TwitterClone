//
//  EditVC.swift
//  Twitter
//
//  Created by MacBook Pro on 15.06.16.
//  Copyright © 2016 Akhmed Idigov. All rights reserved.
//

import UIKit

class EditVC: UIViewController, UITextFieldDelegate {

    // UI obj
    @IBOutlet var usernameTxt: UITextField!
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var surnameTxt: UITextField!
    @IBOutlet var fullnameLbl: UILabel!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var avaImg: UIImageView!
    @IBOutlet var saveBtn: UIButton!
    
    
    // first default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shortcuts
        let username = user!["username"] as? String
        let fullname = user!["fullname"] as? String
        
        let fullnameArray = fullname!.characters.split {$0 == " "}.map(String.init) // include 'Fistname Lastname' as array of seperated elements
        let firstname = fullnameArray[0]
        let lastname = fullnameArray[1]
        
        let email = user!["email"] as? String
        let ava = user!["ava"] as? String
        
        
        // assign shortcuts to obj
        navigationItem.title = "PROFILE"
        usernameTxt.text = username
        nameTxt.text = firstname
        surnameTxt.text = lastname
        emailTxt.text = email
        fullnameLbl.text = "\(nameTxt.text!) \(surnameTxt.text!)"
        
        // get user profile picture
        if ava != "" {
            
            // url path to image
            let imageURL = URL(string: ava!)!
            
            // communicate back user as main queue
            DispatchQueue.main.async(execute: {
                
                // get data from image url
                let imageData = try? Data(contentsOf: imageURL)
                
                // if data is not nill assign it to ava.Img
                if imageData != nil {
                    DispatchQueue.main.async(execute: {
                        self.avaImg.image = UIImage(data: imageData!)
                    })
                }
            })
            
        }

        // round corners
        avaImg.layer.cornerRadius = avaImg.bounds.width / 2
        avaImg.clipsToBounds = true
        saveBtn.layer.cornerRadius = saveBtn.bounds.width / 4.5
        
        // color
        saveBtn.backgroundColor = colorBrandBlue
        
        // disable button initially
        saveBtn.isEnabled = false
        saveBtn.alpha = 0.4
        
        
        // delegating textFields
        usernameTxt.delegate = self
        nameTxt.delegate = self
        surnameTxt.delegate = self
        emailTxt.delegate = self
        
        // add target to textfield as execution of function
        nameTxt.addTarget(self, action: #selector(EditVC.textFieldDidChange(_:)), for: .editingChanged)
        surnameTxt.addTarget(self, action: #selector(EditVC.textFieldDidChange(_:)), for: .editingChanged)
        usernameTxt.addTarget(self, action: #selector(EditVC.textFieldDidChange(_:)), for: .editingChanged)
        emailTxt.addTarget(self, action: #selector(EditVC.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    // calling once entered any chars in name / surname textfields
    func textFieldDidChange(_ textField : UITextView) {
        fullnameLbl.text = "\(nameTxt.text!) \(surnameTxt.text!)"
        
        // if textfields are empty - disable save button
        if usernameTxt.text!.isEmpty || nameTxt.text!.isEmpty || surnameTxt.text!.isEmpty || emailTxt.text!.isEmpty {
            
            saveBtn.isEnabled = false
            saveBtn.alpha = 0.4
            
            // enable button if changed and there is some text
        } else {
            
            saveBtn.isEnabled = true
            saveBtn.alpha = 1
            
        }
    }
    
    
    // clicked save button
    @IBAction func save_clicked(_ sender: AnyObject) {
        
        // if no text
        if usernameTxt.text!.isEmpty || emailTxt.text!.isEmpty || nameTxt.text!.isEmpty || surnameTxt.text!.isEmpty {
            
            //red placeholders
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName: colorSmoothRed])
            emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.red])
            nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSForegroundColorAttributeName: colorSmoothRed])
            surnameTxt.attributedPlaceholder = NSAttributedString(string: "surname", attributes: [NSForegroundColorAttributeName: colorSmoothRed])
            
        // if text is entered
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            // shortcuts
            let username = usernameTxt.text!.lowercased()
            let fullname = fullnameLbl.text!
            let email = emailTxt.text!.lowercased()
            let id = user!["id"]!
            
            // preparing request to best
            let url = URL(string: "http://localhost/Twitter/updateUser.php")!
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            let body = "username=\(username)&fullname=\(fullname)&email=\(email)&id=\(id)"
            
            request.httpBody = body.data(using: .utf8)
            
            // sending request
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                // no error
                if error == nil {
                    
                    // get main queue to communicate back to user
                    DispatchQueue.main.async(execute: { 
                        
                        do {
                            // declare json var to store $returnArray from php file
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            // assign json to new secure var, prevent from crashes
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            // get if from parseJSON dictionary
                            let id = parseJSON["id"]
                            
                            
                            // successfully updated
                            if id != nil {
                                
                                // save user information we received from our host
                                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                                
                                // go to tabbar / home page
                                DispatchQueue.main.async(execute: {
                                    appDelegate.login()
                                })
                                
                            }
                            
                            
                        // error while jsoning
                        } catch {
                            print("Caught an error: \(error)")
                        }
                        
                    })
                    
                    
                // error with php request
                } else {
                    print("Error: \(error)")
                }
                
            }.resume()
            
            
        }
    }
    
    
}










