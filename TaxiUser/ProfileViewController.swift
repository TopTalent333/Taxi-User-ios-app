//
//  ProfileViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 26/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,MainCategoryProtocol,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
     var logindata : SignupLoginResponse!
    
    
    var logoutdata : LogOutModel!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var ueremail: UITextField!
    
    @IBOutlet weak var userimage: UIImageView!
    
    var editname = ""
    
    var editemail = ""
    
    var edituserimage = ""
    
    
   // @IBOutlet weak var username: UILabel!
    
   // @IBOutlet weak var useremail: UILabel!
    
    @IBOutlet weak var usermobile: UILabel!
    
    let imageUrl = API_URL.imagedomain
    
    let Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyname)
    
    
    
    let email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyemail)
    
    let mobile = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyphonenumber)
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
     let image = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyimage)

     let facebookimage = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.keyfacbookimage)
    
     let googleimage = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.keygoogleimage)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ProfileViewController.imageTapped(_:)))
        userimage.isUserInteractionEnabled = true
        userimage.addGestureRecognizer(tapGestureRecognizer)
        
        userimage.layer.cornerRadius =  userimage.frame.width/2
        userimage.clipsToBounds = true
        userimage.layer.borderWidth = 1
        userimage.layer.borderColor = UIColor.black.cgColor
        

        
        
        if image != ""{
            
            
            
            edituserimage = image!
            
            
            
            let newUrl =  image!
            let url = URL(string: newUrl)
            userimage.af_setImage(withURL:
                url! as URL,
                                  placeholderImage: UIImage(named: "dress"),
                                  filter: nil,
                                  imageTransition: .crossDissolve(1.0))
            

            

        
        
        }else if googleimage != ""{
            
            let newUrl = googleimage
           
           edituserimage = googleimage!
            
            let url1 = NSURL(string: newUrl!)
            
            
            userimage!.af_setImage(withURL:
                url1! as URL,
                                       placeholderImage: UIImage(named: "dress"),
                                       filter: nil,
                                       imageTransition: .crossDissolve(1.0))
            

        
        
        }else if facebookimage != ""{
            
            
            let newUrl = facebookimage
            
            edituserimage = facebookimage!
            
            let url1 = NSURL(string: newUrl!)
            
            
            userimage!.af_setImage(withURL:
                url1! as URL,
                                   placeholderImage: UIImage(named: "dress"),
                                   filter: nil,
                                   imageTransition: .crossDissolve(1.0))
        
        }else{
            
           
            
        
            userimage.image = UIImage(named: "profileeee") as UIImage?

        }
        
        editname = Name!
        
        editemail = email!
        
        self.ueremail.text! = email!
        self.username.text! = Name!
        
        self.usermobile.text! = mobile!


        // Do any additional setup after loading the view.
    }
    
    
    func imageTapped(_ img: AnyObject)
    {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            userimage.image = pickedImage
            
           
        }
        
        dismiss(animated: true, completion: nil)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donebtn_click(_ sender: Any) {
        
        editname = username.text!
        
        editemail = ueremail.text!
        
        
        if editemail == ""{
        
            self.showalert(message: NSLocalizedString("Please enter email first.", comment : ""))
        
        }else{
        
        
        
        let parameters = [
            "user_name": editname,
            "user_email": editemail,
            "user_id": self.Userid,
            "language_code":GlobalVarible.languagecode
           
            
        ]
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.uploadRequest(parameters: parameters as! [String : String], driverImage: userimage.image!)
        
        }
        
       
        
    }
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutbtn(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title:  NSLocalizedString("Log Out", comment: ""), message: NSLocalizedString("Are You Sure to Log Out ?", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Confirm", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
            
           // ApiManager.sharedInstance.protocolmain_Catagory = self
           //ApiManager.sharedInstance.logoutUser(UserId: self.Userid!)
            
             let uniqueid =  UserDefaults.standard.string(forKey: "unique_number")
            
            let dic=[ LogoutUrl1:"\(self.Userid!)",
                LogoutUrl2:"\(uniqueid!)",
                LogoutUrl3:"\(GlobalVarible.languagecode)"
            
            ]
            
            print(dic)
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.logoutUser(dictonary: dic as NSDictionary, url: LogoutUrl)
            
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
            refreshAlert .dismiss(animated: true, completion: nil)
            
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)

        
        
    }
    
    
    
    func showalert(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
                
                
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    func showalert2(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
                
                NsUserDekfaultManager.SingeltionInstance.logOut()
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let splashViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
                
                self.present(splashViewController, animated:true, completion:nil)
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                
            }
            
            
        })
        
    }

    
    
    func onProgressStatus(value: Int) {
        if(value == 0 ){
            MBProgressHUD.hide(for: self.view, animated: true)
        }else if (value == 1){
            let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
            spinnerActivity.detailsLabel.text = NSLocalizedString("Please Wait!!", comment: "")
            spinnerActivity.isUserInteractionEnabled = false
            
        }
    }
    
    func onSuccessExecution(msg: String) {
        print("\(msg)")
    }
    
    
    func onerror(msg : String) {
        MBProgressHUD.hide(for: self.view, animated: true)
        
        self.showalert(message: msg)
        
    }
    
    
    
    func onSuccessParse(data: AnyObject) {
        
        
        if(GlobalVarible.Api == "editprofile"){
        
        logindata = data as! SignupLoginResponse
            
              if logindata.result == 1{
                
                
                NsUserDekfaultManager.SingeltionInstance.loginuser(user_id: self.logindata.details!.userId!,name: self.logindata.details!.userName!, image: (self.logindata.details?.userImage)!, email: self.logindata.details!.userEmail!, phonenumber: (self.logindata.details?.userPhone!)!, status: self.logindata.details!.status!,password: self.logindata.details!.userPassword!,facbookimage: (self.logindata.details?.facebookImage!)!, googleimage: (self.logindata.details?.googleImage)!)
                

        
            let alert = UIAlertController(title: NSLocalizedString("Profile Updated", comment: ""), message:"", preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                
                if let window = self.view.window{
                    window.rootViewController = nextController
                }
                
                
            }
            alert.addAction(action)
            self.present(alert, animated: true){}
                
              }else{
            
                self.showalert(message: NSLocalizedString("Please try again.", comment : ""))
            
            
            }
        
        
        
        }
        
        
        if(GlobalVarible.Api == "userlogout"){
            
            logoutdata = data as! LogOutModel
            
            if(logoutdata.result == 1){
                
                NsUserDekfaultManager.SingeltionInstance.logOut()
                
                self.showalert2(message: logoutdata.msg!)
                
            }else{
                
                self.showalert(message: logoutdata.msg!)
            }
            
            
        }

    }
    

   
}
