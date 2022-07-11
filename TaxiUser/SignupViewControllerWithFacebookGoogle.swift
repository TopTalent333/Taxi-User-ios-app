//
//  SignupViewControllerWithFacebookGoogle.swift
//  TaxiUser
//
//  Created by AppOrio on 22/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import Fabric
import DigitsKit

class SignupViewControllerWithFacebookGoogle: UIViewController,MainCategoryProtocol,MICountryPickerDelegate {
    
    var logindata : SignupLoginResponse!
    
    @IBOutlet weak var userimageview: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var useremail: UILabel!
    
    
    @IBOutlet var container: UIView!
    
    @IBOutlet var phoneButton: UIButton!
    
    @IBOutlet weak var countrycodetext: UILabel!
    
    @IBOutlet weak var enterphonetext: UITextField!
    
   // @IBOutlet var firstName: UITextField!
   // @IBOutlet var lastName: UITextField!
    
    var selcetcountrycode = "+27"
    
    var phonetext = ""
    
    var movedFrom = ""
    
    var facebookFirstName = ""
    var facebookLastName = ""
    var googleFirstName = ""
    var googleLastName = ""
    var facebookId = ""
    var googleId = ""
    var googleMail = ""
    var googleImage = ""
    var facebookMail = ""
    var facebookImage = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userimageview.layer.cornerRadius =  userimageview.frame.width/2
        userimageview.clipsToBounds = true
        userimageview.layer.borderWidth = 1
        userimageview.layer.borderColor = UIColor.white.cgColor
        


        self.container.edgeWithShadow()
        
        if movedFrom == "google"{
            
            if(googleImage == ""){
                userimageview.image = UIImage(named: "profileeee") as UIImage?
               
                print("No Image")
            }else{
                let newUrl = googleImage
                // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                print(newUrl)
                
                let url1 = NSURL(string: newUrl)
                
                
                userimageview!.af_setImage(withURL:
                    url1! as URL,
                                                 placeholderImage: UIImage(named: "dress"),
                                                 filter: nil,
                                                 imageTransition: .crossDissolve(1.0))
                
            }
            
            
            self.username.text = googleFirstName
             self.useremail.text = googleMail
        }
        else
        {
            
            
            if(facebookImage == ""){
                userimageview.image = UIImage(named: "profileeee") as UIImage?
                
                print("No Image")
            }else{
                let newUrl = facebookImage
                // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                print(newUrl)
                
                let url1 = NSURL(string: newUrl)
                
                
                userimageview!.af_setImage(withURL:
                    url1! as URL,
                                           placeholderImage: UIImage(named: "dress"),
                                           filter: nil,
                                           imageTransition: .crossDissolve(1.0))
                
            }

            
            self.username.text = facebookFirstName
            self.useremail.text = facebookMail
        }
        
        
       // self.signoutTwiterDegit()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        
    }
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        selcetcountrycode = dialCode
        countrycodetext.text = dialCode
        self.dismiss(animated: true, completion: nil)
       
        
    }

    
    @IBAction func onRegister(_ sender: Any) {
        
        self.view.endEditing(true)
        
        
        phonetext = self.enterphonetext.text!
        
       /* if (self.firstName.text?.characters.count)! < 2 {
            self.showalert(message: "Please Enter Valid Name")
            // self.showBannerError("Message", subTitle: "Please Enter Valid Name", imageName: "")
            return
        }
        
        if movedFrom != "google"{
            
            if (self.lastName.text?.characters.count)! < 2 {
                self.showalert(message: "Please check Last Name")
                //  self.showBannerError("Message", subTitle: "Please check Last Name", imageName: "")
                return
            }
        }*/
        
        
        if phonetext == ""{
            self.showalert(message: NSLocalizedString("Please Enter Mobile Number First", comment: ""))
            //  self.showBannerError("Message", subTitle: "Please Enter Valid Mobile Number", imageName: "")
            return
        }
        
        
        
        
        if movedFrom == "facebook" {
            
            let dic=[ facebookSignupUrl2:"\(self.facebookId)",
                facebookSignupUrl3:"\(self.facebookMail)",
                facebookSignupUrl4:"\(self.facebookImage)",
                facebookSignupUrl5:"\(facebookFirstName)",
                facebookSignupUrl6:"\(facebookLastName)",
                facebookSignupUrl7:"\(selcetcountrycode + self.enterphonetext.text!)",
                facebookSignupUrl8:"\(facebookFirstName)",
                facebookSignupUrl9:"\(facebookLastName)",
                facebookSignupUrl10:"\(GlobalVarible.languagecode)"
            ]
            
            for items in dic{
                print(items.1)
            }
            
            print(dic)
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.postData(dictonary: dic as NSDictionary, url: facebookSignupUrl)
            
            //  ApiController.sharedInstance.parsPostData(dic, url:facebookSignupUrl, reseltCode: 10)
            
        }
        
        
        if movedFrom == "google"{
            
            let dic=[ googleSignupUrl2:"\(self.googleId)",
                googleSignupUrl3:"\(googleFirstName)",
                googleSignupUrl4:"\(self.googleMail)",
                googleSignupUrl5:"\(self.googleImage)",
                googleSignupUrl6:"\(selcetcountrycode + self.enterphonetext.text!)",
                googleSignupUrl7:"\(googleFirstName)",
                googleSignupUrl8:"\(googleLastName)",
                googleSignupUrl9:"\(GlobalVarible.languagecode)"
                
            ]
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.postData(dictonary: dic as NSDictionary, url: googleSignupUrl)
            
            //  ApiController.sharedInstance.parsPostData(dic, url:googleSignupUrl, reseltCode: 10)
            
        }
        
        
        

    }
   
    
    @IBAction func onPhone(_ sender: Any) {
        
      /* let digits = Digits.sharedInstance()
        
        digits.authenticate { (session, error) in
            
            if (session != nil) {
                // TODO: associate the session userID with your user model
                print(session!.phoneNumber)
                self.phoneButton.setTitle(session!.phoneNumber, for: .normal)
                self.phoneButton.setTitleColor(UIColor.black, for: .normal)
                self.signoutTwiterDegit()
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        }*/
        
        
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        
        picker.delegate = self
        
        // Display calling codes
        picker.showCallingCodes = true
        
        // or closure
        picker.didSelectCountryClosure = { name, code in
        }
        
        self.present(picker, animated: true, completion: nil)
        
        

    }
    
    
    
    
      
    
    func signoutTwiterDegit()
    {
        Digits.sharedInstance().logOut()
        
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
        
        logindata = data as! SignupLoginResponse
        
        if logindata.result == 1{
            
            let userid = logindata.details!.userId
            
            let UserDeviceKey = UserDefaults.standard.string(forKey: "device_key")
            
                      
            print(UserDeviceKey!)
            
            let uniqueid =  UserDefaults.standard.string(forKey: "unique_number")
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.UserDeviceId(USERID: userid!, USERDEVICEID: UserDeviceKey! , FLAG: "1",UNIQUEID: uniqueid!)
            
            NsUserDekfaultManager.SingeltionInstance.loginuser(user_id: self.logindata.details!.userId!,name: self.logindata.details!.userName!, image: (self.logindata.details?.userImage)!, email: self.logindata.details!.userEmail!, phonenumber: (self.logindata.details?.userPhone!)!, status: self.logindata.details!.status!,password: self.logindata.details!.userPassword!,facbookimage: (self.logindata.details?.facebookImage!)!, googleimage: (self.logindata.details?.googleImage)!)
            
            
            
            
          /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let revealViewController:MapViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            
            self.present(revealViewController, animated:true, completion:nil)*/
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            
            if let window = self.view.window{
                window.rootViewController = nextController
            }
            

            
            
        }else{
            
            
        }
        
        
    }
    
    



   

}
