//
//  FBLoginViewController.swift
//  IVORY
//
//  Created by Jiapei Liang on 1/13/16.
//  Copyright © 2016 ZengJintao. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Socket_IO_Client_Swift

class FBLoginViewController: UIViewController {
    
    var myLoginButton: UIButton!
    
    var server: String! = "http://10.186.137.182:4000/auth/facebook/token?access_token="
    
    let socket = SocketIOClient(socketURL: "http://10.186.137.182:4000", options: [.Log(true), .ForcePolling(true)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            //goToChooseUniversityView();
        }
    }
    
    @IBAction func loginWithFBTapped(sender: AnyObject) {
        var login: FBSDKLoginManager = FBSDKLoginManager()
        
        login.logInWithReadPermissions(["public_profile"], fromViewController: self, handler: {(result, error) -> Void in
            if error != nil {
                NSLog("Process error")
            }
            else if result.isCancelled {
                NSLog("Cancelled")
            }
            else {
                NSLog("Logged in")
                self.myLoginButton.setTitle("Log out", forState: .Normal)
                
                // perform segue
                //self.goToChooseUniversityView()
                
                
                let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])
                
                graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
                    
                    if error != nil {
                        
                        print(error)
                        
                    } else if let result = result {
                        
                        print("gender: \(result["gender"] as! String)")
                        
                        print("name: \(result["name"] as! String)")
                        
                        let token = FBSDKAccessToken.currentAccessToken().tokenString
                        
                        print("Token: \(token)");
                        
                        
                        self.connectToSocket(token)
                        
                        
                        
                        var userId = result["id"] as! String
                        
                        print("id: \(userId)")
                        
                        let facebookProfileImgUrl = "http://graph.facebook.com/" + userId + "/picture?type=large"
                        
                        print(facebookProfileImgUrl);
                        
                        if let fbpicUrl = NSURL(string: facebookProfileImgUrl) {
                            
                            if let data = NSData(contentsOfURL: fbpicUrl) {
                                
                                //print(data)
                                
                            }
                            
                        }
                        
                    }
                }
                
                
            }
            
        })
        
    }

    //func connectToSocket(url: String, signal: String, requestType: String) {}
        
    func connectToSocket(token: String) {
        // making GET request
        let url = NSURL(string:"\(self.server)\(token)");
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            
            
            
            //var testString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            
            
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            
            
            do {
                var dict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                
                print(dict!)
                
                var newDict:NSDictionary = ["token" : dict!["accessToken"]!]
                
                print(newDict)
                
                
                
                self.socket.on("connect") { data, ack in
                    print("socket connected")
                    
                    //socket.emit("authenticate", {token: data})
                    self.socket.emit("authenticate", newDict)
                    self.socket.on("authenticated", callback: { (_: [AnyObject], b) -> Void in
                        print("success")
                        
                        self.socket.on("messagearrive", callback: { (a, SocketAckEmitter) -> Void in
                            print(a)
                        })
                    })
                }
                
                self.socket.connect()
                
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func goToChooseUniversityView() {
        // perform segway
        performSegueWithIdentifier("goToChooseUniversity", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
