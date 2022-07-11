//
//  NsUserDekfaultManager.swift
//  TaxiApp
//
//  Created by AppOrio on 22/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import Foundation

 
public class NsUserDekfaultManager {


   // internal static let Keyflag = "flag"
    internal static let Keyuserid = "user_id"
    internal static let Keyname = "name"
    internal static let Keyimage = "image"
    internal static let Keyemail = "email"
    internal static let Keyphonenumber = "phone_number"
    internal static let Keystatus = "status"
    internal static let Keypassword = "password"
    internal static let keyfacbookimage = "facebookimage"
    internal static let keygoogleimage = "googleimage"
    internal static let KeyloginState = "LoginState"


    internal static let SingeltionInstance  = NsUserDekfaultManager()
    
    
    
    
    func loginuser(user_id : String  ,  name : String , image : String , email : String , phonenumber : String , status :String , password : String, facbookimage: String, googleimage: String){
        
        
       // UserDefaults.standard.setValue(flag, forKey: "flag")
        UserDefaults.standard.setValue(user_id, forKey: "user_id")
         UserDefaults.standard.setValue(name, forKey: "name")
         UserDefaults.standard.setValue(image, forKey: "image")
         UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue(phonenumber, forKey: "phone_number")
         UserDefaults.standard.setValue(status, forKey: "status")
        UserDefaults.standard.setValue(password, forKey: "password")
        UserDefaults.standard.set(facbookimage, forKey: "facebookimage")
        UserDefaults.standard.set(googleimage, forKey: "googleimage")
        UserDefaults.standard.set(true, forKey: "LoginState")
        
    
      //  NSUserDefaults.standardUserDefaults().setBool(true, forKey: "LoginState")
        
        
    }
    
     
    
    func isloggedin() -> Bool{
        
        let  loginstate  =  UserDefaults.standard.bool(forKey: "LoginState")
        
        if loginstate  {
            return true
        }else{
            return false
        }
    }
    

    


    func getuserdetaild (key : String)-> String?
    {
        
        return  UserDefaults.standard.string(forKey: key)!
    }
    


    func logOut(){
        
        
       /* let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()

        GIDSignIn.sharedInstance().signOut()*/
        
        


        let defaults =  UserDefaults.standard
        defaults.removeObject(forKey: "user_id")
        defaults.removeObject(forKey: "name")
        defaults.removeObject(forKey: "image")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "phone_number")
        defaults.removeObject(forKey: "status")
       // defaults.removeObject(forKey: "flag")
        defaults.removeObject(forKey: "password")
        defaults.removeObject(forKey: "facebookimage")
         defaults.removeObject(forKey: "googleimage")
        defaults.set(false, forKey:"LoginState")
      
        
        
        
    }
    




}
