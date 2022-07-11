
//
//  Validation+EmailandPhone.swift
//  CabinCarriers
//
//  Created by ashish on 27/04/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
   
    //To check text field or String is blank or not
   /* var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return trimmed.isEmpty
        }
    }*/
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    //Replace string code
    
    
   /* func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSString.CompareOptions.LiteralSearch, range: nil)
    }*/

    
    
    
    //validate PhoneNumber
   /* var isPhoneNumber: Bool {
        
        let charcter  = NSCharacterSet(charactersInString: "+0123456789").invertedSet
       var filtered:NSString!
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        filtered = inputString.componentsJoined(by: "")
      
        
  let charCount=self.characters.count
       // if charCount == 10{
        if charCount>9 && charCount<13{
            return true
        }else{
          return  false
        }
         return  self == filtered
        
        
    }*/
    
    var isPassword:Bool{
        
        let charCount=self.characters.count
        if charCount>0 && charCount<30{
            return true
        }else{
            return false
        }
        
    }
    
    
    
    
    
}


extension String{
    func trim()->String{
        
        let newString = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
       /* let newString=self.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )*/
        return newString
    }
}


/*extension UITextField{
    
    func padding(){
        
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 6, self.frame.height))
        self.leftView = paddingView2
        self.leftViewMode = UITextFieldViewMode.always
        
    }
    
}*/
