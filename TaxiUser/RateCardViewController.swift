//
//  RateCardViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 24/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class RateCardViewController: UIViewController,UIPickerViewDelegate,UITextFieldDelegate,MainCategoryProtocol {
    
    var mydata: CityName!
    var Cardata: CarType!
    var ratecarddata: RateCardModel!
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var ridedistancefirst2: UILabel!
    
    @IBOutlet weak var ridedistanceafter2: UILabel!
    
    @IBOutlet weak var ridedistancefirst2charges: UILabel!
    
    @IBOutlet weak var ridedistanceafter2charges: UILabel!
    
    
    @IBOutlet weak var peaktimechargesprice: UILabel!
    
    @IBOutlet weak var nighttimechargesprice: UILabel!
    
    
    @IBOutlet weak var ridetimefirst2: UILabel!
    
    @IBOutlet weak var ridetimeafter2: UILabel!
    
    @IBOutlet weak var ridetimefirst2charges: UILabel!
    
    @IBOutlet weak var ridetimeafter2charges: UILabel!
    
    @IBOutlet weak var citynamelabel: UILabel!
    
    @IBOutlet weak var carnamelabel: UILabel!
    
    @IBOutlet weak var waitingtimefirst2: UILabel!
    
    @IBOutlet weak var waitingtimeafter2: UILabel!
    
    @IBOutlet weak var waitingtimefirst2charges: UILabel!
    
    @IBOutlet weak var waitingtimeafter2charges: UILabel!
    
    //  @IBOutlet weak var city: UITextField!
    
    //  @IBOutlet weak var car: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var newcity: UITextField!
    
    @IBOutlet weak var newcar: UITextField!
    
    
    // var city_name : NSMutableArray = []
    
    var movedfrom = " "
    var cityid = "3"
    var carid = " "
    var cityname = ""
    var citysize = 0
    var carsize = 0
    @IBOutlet weak var firstkmlabel: UILabel!
    
    @IBOutlet weak var afterkmlabel: UILabel!
    @IBOutlet weak var first2kmrate: UILabel!
    @IBOutlet weak var after2kmrate: UILabel!
    
    
    
    let pickerView = UIPickerView()
    
    let textField = UITextField()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.layer.borderWidth = 1.0
        mainview.layer.borderColor = UIColor.lightGray.cgColor
        mainview.layer.cornerRadius = 4
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RateCard(City: self.cityid, CarTypeId: GlobalVarible.car_type_id)
        movedfrom = "RateCard"
        
        citynamelabel.text = GlobalVarible.usercityname
        carnamelabel.text = GlobalVarible.firstcarname
        
        // city.text = GlobalVarible.usercityname
        //  car.text = GlobalVarible.firstcarname
        
       let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
       
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action:#selector(RateCardViewController.tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action:#selector(RateCardViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 2, height: (self.view.frame.size.height + 5)))
        
        label.font = UIFont(name: "AvenirNextCondensed-Medium", size: 18)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = NSLocalizedString("Select City ", comment: "")
        
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        newcity.inputAccessoryView = toolBar
        
        
        pickerView.delegate = self
        textField.delegate = self
        
        
        newcity.inputView = pickerView
        //  citynamelabel.inputView = pickerView
        
        
        let toolBar1 = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar1.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar1.barStyle = UIBarStyle.blackTranslucent
        
        toolBar1.tintColor = UIColor.white
        
        toolBar1.backgroundColor = UIColor.black
        
        let defaultButton1 = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action:#selector(RateCardViewController.tappedToolBarBtn1))
        
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action:#selector(RateCardViewController.donePressed1))
        
        let flexSpace1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 2, height: (self.view.frame.size.height + 5)))
        
        label1.font = UIFont(name: "AvenirNextCondensed-Medium", size: 18)
        
        label1.backgroundColor = UIColor.clear
        
        label1.textColor = UIColor.white
        
        label1.text = NSLocalizedString("Select Car ", comment: "")
        
        
        label1.textAlignment = NSTextAlignment.center
        
        let textBtn1 = UIBarButtonItem(customView: label1)
        
        toolBar1.setItems([defaultButton1,flexSpace1,textBtn1,flexSpace1,doneButton1], animated: true)
        
        newcar.inputAccessoryView = toolBar1
        newcar.inputView = pickerView


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // self.mainview.frame.size.height = 700
        self.scrollview.frame = self.scrollview.bounds
        self.scrollview.contentSize.height = 700
        self.scrollview.contentSize.width = 0
        
    }
    

    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        
        citynamelabel.text = ""
        
        carnamelabel.text = ""
        
        newcity.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn1(sender: UIBarButtonItem) {
        
        carnamelabel.text = ""
       
        
        newcar.resignFirstResponder()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == newcity
        {
            carnamelabel.text = ""
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.CityList()
            movedfrom = "City"
            
        }
        
        
        if textField == newcar
        {
            
            if(citynamelabel.text!.characters.count == 0){
                
                newcar.resignFirstResponder()
                
                self.showalert(message: NSLocalizedString("Please select City first!!", comment: ""))
                
                // return false
                
            }else{
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.viewcars(UserCityName: cityid)
                movedfrom = "Car"
                
            }
        }
        
        
        // return true
    }
    
    
    func donePressed(sender: UIBarButtonItem) {
        
        newcity.resignFirstResponder()
        // car.resignFirstResponder()
        
        
    }
    
    func donePressed1(sender: UIBarButtonItem) {
        
        
        newcar.resignFirstResponder()
        
        
        if(citynamelabel.text!.characters.count == 0  && carnamelabel.text!.characters.count == 0){
            self.showalert( message: NSLocalizedString("Please select both filled Car & City!!", comment: ""))
            
        }
        else{
            ApiManager.sharedInstance.protocolmain_Catagory = self
            // ApiManager.sharedInstance.RateCard(self.carid, CityId: self.cityid)
            ApiManager.sharedInstance.RateCard(City: self.cityid, CarTypeId: self.carid)
            movedfrom = "RateCard"
            
        }
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if movedfrom == "City" {
            
            return citysize
            
        }
        else{
            
            return carsize
            
            
            
            
        }
        
        
        
    }
    
    
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if movedfrom == "City" {
            
            if(UserDefaults.standard.object(forKey: "PreferredLanguage") as! String == "en"){
                return mydata.msg![row].cityName
                
            }else{
                return mydata.msg![row].cityName
                
            }
            
            
            // return mydata.msg![row].cityName
        }
            
        else{
            if(UserDefaults.standard.object(forKey: "PreferredLanguage") as! String == "en"){
                return Cardata.msg![row].carTypeName
                
                
            }else{
                return Cardata.msg![row].carTypeName
                
                
            }
            
            
            
            // return Cardata.msg![row].carTypeName
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if movedfrom == "City" {
            
            
            if(UserDefaults.standard.object(forKey: "PreferredLanguage") as! String == "en"){
                citynamelabel.text = mydata.msg![row].cityName
                cityname = mydata.msg![row].cityName!
                cityid = mydata.msg![row].cityId!
                
            }else{
                citynamelabel.text = mydata.msg![row].cityName
                cityname = mydata.msg![row].cityName!
                cityid = mydata.msg![row].cityId!
                
            }
            
            
            // city.text = mydata.msg![row].cityName
            // cityname = mydata.msg![row].cityName!
            // cityid = mydata.msg![row].cityId!
            
        }
        else{
            
            
            if(UserDefaults.standard.object(forKey: "PreferredLanguage") as! String == "en"){
                //return Cardata.msg![row].carTypeName
                carnamelabel.text = Cardata.msg![row].carTypeName
                carid = Cardata.msg![row].carTypeId!
                
                
            }else{
                // return Cardata.msg![row].carNameOther
                carnamelabel.text = Cardata.msg![row].carTypeName
                carid = Cardata.msg![row].carTypeId!
                
                
            }
            
                   }
        
        
        
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
        
        if movedfrom == "City"
        {
            mydata = data as! CityName
            
            
            if(mydata.result == 0){
                citysize = 0
                
            }else{
                citysize = (mydata.msg?.count)!
                
                if(UserDefaults.standard.object(forKey: "PreferredLanguage") as! String == "en"){
                    citynamelabel.text = mydata.msg![0].cityName
                    cityid = mydata.msg![0].cityId!
                    
                }else{
                    citynamelabel.text = mydata.msg![0].cityName
                   cityid = mydata.msg![0].cityId!
                    
                }
                
            }
            
        }
        
        if(GlobalVarible.Api == "getcartype"){
            //  mydata = data as! CarType
            
            if movedfrom == "Car"
            {
                Cardata = data as! CarType
                
                if(Cardata.result == 0){
                    carsize = 0
                    
                }else{
                    carsize = (Cardata.msg?.count)!
                    
                    
                    if(UserDefaults.standard.object(forKey: "PreferredLanguage") as! String == "en"){
                        //return Cardata.msg![row].carTypeName
                        carnamelabel.text = Cardata.msg![0].carTypeName
                        carid = Cardata.msg![0].carTypeId!
                        
                        
                    }else{
                        // return Cardata.msg![row].carNameOther
                        carnamelabel.text = Cardata.msg![0].carTypeName
                        carid = Cardata.msg![0].carTypeId!
                        
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        if movedfrom == "RateCard"
        {
            ratecarddata = data as! RateCardModel
            
            if(ratecarddata.result == 0){
                
                citynamelabel.text = ""
                
                carnamelabel.text = ""

                
                self.showalert(message: ratecarddata.msg!)
                
            }else{
                
                
                
                
                
                ridedistancefirst2.text =  "Base Ride Distance Charges"
                    ridedistanceafter2.text = "After Base Ride Distance Charges"
                
                
            
                
                ridedistancefirst2charges.text =  GlobalVarible.currencysymbol + " " + (ratecarddata.details!.baseDistancePrice)! + " for " + (ratecarddata.details?.baseDistance)! + " " + (ratecarddata.details?.distanceUnit)!
                ridedistanceafter2charges.text =  GlobalVarible.currencysymbol + " " + (ratecarddata.details!.basePricePerUnit)! + " per " + (ratecarddata.details?.distanceUnit)!
                
             
                
                ridetimefirst2.text =  "Free Ride Time"
                ridetimeafter2.text = "After Free Ride Time Charges"
                
                ridetimefirst2charges.text =   (ratecarddata.details!.freeRideMinutes)! + "min"
                ridetimeafter2charges.text =  GlobalVarible.currencysymbol + " " + (ratecarddata.details!.pricePerRideMinute)! + NSLocalizedString(" per min", comment: "")
                
                
                waitingtimefirst2.text =  "Free Waiting Time"
                waitingtimeafter2.text = "After Free Waiting Time Charges"
                waitingtimefirst2charges.text =  (ratecarddata.details!.freeWaitingTime)! + "min"
                waitingtimeafter2charges.text = GlobalVarible.currencysymbol + " " + (ratecarddata.details!.watingPriceMinute)!   + NSLocalizedString(" per min", comment: "")
                
                peaktimechargesprice.text = GlobalVarible.currencysymbol + " " + (ratecarddata.details?.peakTimeCharge)!
                
                nighttimechargesprice.text = GlobalVarible.currencysymbol + " " + (ratecarddata.details?.nightTimeCharge)!
                
                
 
            }
            
        }
        
        pickerView.reloadAllComponents()



    }

   

}
