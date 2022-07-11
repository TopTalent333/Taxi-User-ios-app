//
//  FullDetailsViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 26/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import StarryStars

class FullDetailsViewController: UIViewController,MainCategoryProtocol {
    
    var mailinvoicedata: MailInvoiceModel!
    
    var mydatapage: NormalViewRideInfoModel!
    
    var rentalridedata: RentalViewRideInfoModel!
    
    
    var newgoogledistancemodel: NewGoogleDistanceModel!
    
     @IBOutlet weak var showdatetimelabel: UILabel!
    
    var ridestausvalue = ""
    var datetimedata = ""
    var rideid = ""
    var donerideid = ""
     var ridemode = ""
    
    var latroute1: [Double] = [Double]()
    var longroute1: [Double] = [Double]()
    
    let imageUrl = API_URL.imagedomain
    //   var rideid = ""
    
    var value = ""
    
    var dropuplat : Double!
    var  dropuplong : Double!
    
    var pickuplat : Double!
    var pickuplong : Double!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    
    @IBOutlet weak var completemapimageview: UIImageView!
    
    @IBOutlet weak var completestatusview: UIView!
    
    
    @IBOutlet weak var completestatusbottomview: UIView!
    
    @IBOutlet weak var completedriverimage: UIImageView!
    
    @IBOutlet weak var completeratingview: RatingView!
    
    @IBOutlet weak var completedrivername: UILabel!
    
    @IBOutlet weak var completecarimage: UIImageView!
    
    @IBOutlet weak var completecarname: UILabel!
    
    @IBOutlet weak var completeprice: UILabel!
    
    @IBOutlet weak var completedistance: UILabel!
    
    @IBOutlet weak var completetime: UILabel!
    
    @IBOutlet weak var completepickuplocation: UILabel!
    
    @IBOutlet weak var completedroplocation: UILabel!
    
    @IBOutlet weak var completetotalprice: UILabel!
    
    @IBOutlet weak var completepickuptime: UILabel!
    
    @IBOutlet weak var completedropuptime: UILabel!
    
    
    @IBOutlet weak var completedistancetravel: UILabel!
    
    
    @IBOutlet weak var completedistancefare: UILabel!
    
    @IBOutlet weak var completeridetimecharges: UILabel!
    
    @IBOutlet weak var completewaitingcharge: UILabel!
    
    @IBOutlet weak var completepaymentmethod: UILabel!
    
    @IBOutlet weak var completepaymentmethodwithprice: UILabel!
    
    @IBOutlet weak var completecoupontext: UILabel!
    
    @IBOutlet weak var completecouponprice: UILabel!
    
    @IBOutlet weak var completenighttimechargestext: UILabel!
    
    @IBOutlet weak var completepeaktimechargestext: UILabel!
    
    //************************************
    
    @IBOutlet weak var Acceptedmapimageview: UIImageView!
    
    @IBOutlet weak var Acceptedstatusview: UIView!
    
    @IBOutlet weak var Accepteddriverimage: UIImageView!
    
    @IBOutlet weak var Accepteddrivername: UILabel!
    
    
    @IBOutlet weak var Acceptedratingview: RatingView!
    
    
    @IBOutlet weak var Acceptedcarimage: UIImageView!
    
    
    @IBOutlet weak var Acceptedcarname: UILabel!
    
    @IBOutlet weak var Acceptedpickuplocation: UILabel!
    
    @IBOutlet weak var Accepteddroplocation: UILabel!
    
    
    
    //*******************************************
    
    @IBOutlet weak var ridelatermapimageview: UIImageView!
    
    @IBOutlet weak var ridelaterstatusview: UIView!
    
    @IBOutlet weak var ridelaterpickuplocation: UILabel!
    
    @IBOutlet weak var ridelaterdroplocation: UILabel!
    
    
    
    //**********************
    
    @IBOutlet weak var ridelaterview: UIView!
    
    @IBOutlet weak var driveracceptedview: UIView!
    
    @IBOutlet weak var driverarrivedview: UIView!
    
    // @IBOutlet weak var cancelrideview: UIView!
    
    @IBOutlet weak var normalcompleteview: UIView!
    
    @IBOutlet weak var rentalcompleteview: UIView!
    
    
    @IBOutlet weak var rentaldistancetravel: UILabel!
    
    @IBOutlet weak var rentaltotaltime: UILabel!
    
    @IBOutlet weak var rentalpackagetext: UILabel!
    
    @IBOutlet weak var rentalpackageprice: UILabel!
    
    @IBOutlet weak var rentalextratimetraveltext: UILabel!
    
    @IBOutlet weak var rentalextratimetravelprice: UILabel!
    
    @IBOutlet weak var rentalextraestimatetimetext: UILabel!
    
    @IBOutlet weak var rentalestimatetimeprice: UILabel!
    
    
    @IBOutlet weak var rentaltotalpricetext: UILabel!
    
    @IBOutlet weak var rentalcouponcodetext: UILabel!
    
    @IBOutlet weak var rentaltotalpayableamout: UILabel!
    
    @IBOutlet weak var rentalcouponcodeprice: UILabel!
    

    @IBOutlet weak var rentaltotalpayableamounttext: UILabel!
    
    @IBOutlet weak var ridelaterdetailsdateview: UIView!
    
    
    @IBOutlet weak var bookingdateridelater: UILabel!
    
    @IBOutlet weak var scheduledateridelater: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showdatetimelabel.text = datetimedata
        
        GlobalVarible.cancelbtnvaluematch  = "2"
        
        completeratingview.isUserInteractionEnabled = false
        
      //  GlobalVarible.checkRideId = rideid
        
        // UserDefaults.standard.setValue(ridestausvalue, forKey:"ride_status")
        
        
        print(ridestausvalue)
        
        
        Acceptedratingview.isUserInteractionEnabled = false
        
        if ridemode == "2"{
            
            
            
            if ridestausvalue == "16" {
                completestatusview.isHidden = false
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = false
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                normalcompleteview.isHidden = true
                rentalcompleteview.isHidden = false
                ridelaterdetailsdateview.isHidden = true
                
            }
            
            if ridestausvalue == "10" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = false
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = false
                
            }
            
            if ridestausvalue == "15" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                
            }
            
            if ridestausvalue == "13" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = false
                 ridelaterdetailsdateview.isHidden = true
                
                
                
            }
            
            if ridestausvalue == "14" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                
                
                
            }
            
            if ridestausvalue == "12" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = false
                 ridelaterdetailsdateview.isHidden = true
                
            }
            
            if ridestausvalue == "11" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = false
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                
            }
            
            if ridestausvalue == "19" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                ridelaterdetailsdateview.isHidden = true
                
            }
            
            
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.RentalviewRideInfo(BookingId: rideid, RideMode: ridemode)
            
            
            
        }else{
            
            
            
            
            
            if ridestausvalue == "7" {
                completestatusview.isHidden = false
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = false
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                normalcompleteview.isHidden = false
                rentalcompleteview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                //  cancelrideview.hidden = true
                
            }
            
            if ridestausvalue == "1" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = false
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = false
                //  cancelrideview.hidden = true
                
                
            }
            
            if ridestausvalue == "2" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                // cancelrideview.hidden = false
                
                
            }
            
            if ridestausvalue == "6" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = false
                 ridelaterdetailsdateview.isHidden = true
                // cancelrideview.hidden = true
                
                
            }
            
            if ridestausvalue == "4" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                // cancelrideview.hidden = false
                
                
            }
            
            if ridestausvalue == "5" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = false
                 ridelaterdetailsdateview.isHidden = true
                //  cancelrideview.hidden = true
                
                
            }
            
            if ridestausvalue == "3" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = true
                Acceptedstatusview.isHidden = false
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = false
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                //  cancelrideview.hidden = true
                
                
            }
            
            
            if ridestausvalue == "8"{
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = false
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                //  cancelrideview.hidden = true
                
            }
            
            if ridestausvalue == "9"{
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                 ridelaterdetailsdateview.isHidden = true
                // cancelrideview.hidden = false
                
                
            }
            
            if ridestausvalue == "17" {
                
                completestatusview.isHidden = true
                ridelaterstatusview.isHidden = false
                Acceptedstatusview.isHidden = true
                completestatusbottomview.isHidden = true
                ridelaterview.isHidden = true
                driveracceptedview.isHidden = true
                driverarrivedview.isHidden = true
                ridelaterdetailsdateview.isHidden = true
                // cancelrideview.hidden = false
                
                
            }

            
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.NormalviewRideInfo(BookingId: rideid, RideMode: ridemode)
            
            //  ApiManager.sharedInstance.protocolmain_Catagory = self
            // ApiManager.sharedInstance.DriverInformation(RIDEID: rideid)
            
        }


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
        self.scrollview.contentSize.height = 800
        self.scrollview.contentSize.width = 0
        
    }

    
    @IBAction func backbtn(_ sender: Any) {
        
    self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func completemailinvoicebtn(_ sender: Any) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: SENDEMAILViewController = storyboard.instantiateViewController(withIdentifier: "SENDEMAILViewController") as! SENDEMAILViewController
        next.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
       next.donerideid = self.donerideid
        self.present(next, animated: true, completion: nil)
        
     //  ApiManager.sharedInstance.protocolmain_Catagory = self
      // ApiManager.sharedInstance.Mailinvoice(DoneRideId: donerideid)
    }
    
    @IBAction func Driveracceptedtrackridebtn(_ sender: Any) {
        
         GlobalVarible.checkRideId = rideid
        
         if ridemode == "2"{
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: RentalTrackRideViewController = storyboard.instantiateViewController(withIdentifier: "RentalTrackRideViewController") as! RentalTrackRideViewController
            nextController.Currentrideid = rideid
            self.present(nextController, animated: true, completion: nil)
         }else{
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController: TrackRideViewController = storyboard.instantiateViewController(withIdentifier: "TrackRideViewController") as! TrackRideViewController
        nextController.Currentrideid = rideid
        self.present(nextController, animated: true, completion: nil)
            
        }

    }
    
    @IBAction func Driveracceptedcancelridebtn(_ sender: Any) {
        
        if ridemode == "2"{
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: ReasonDialogController = storyboard.instantiateViewController(withIdentifier: "ReasonDialogController") as! ReasonDialogController
            next.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            next.movefrom = "Rentaltype"
            self.present(next, animated: true, completion: nil)
        }else{
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewController(withIdentifier: "ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            next.movefrom = ""
        self.present(next, animated: true, completion: nil)
        
        }
    }
    
    @IBAction func ridelatercancelridebtn(_ sender: Any) {
        
        if ridemode == "2"{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: ReasonDialogController = storyboard.instantiateViewController(withIdentifier: "ReasonDialogController") as! ReasonDialogController
            next.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
             next.movefrom = "Rentaltype"
            self.present(next, animated: true, completion: nil)
            
        }else{
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewController(withIdentifier: "ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            next.movefrom = ""
        self.present(next, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func driverarrivedtrackridebtn(_ sender: Any) {
        
         GlobalVarible.checkRideId = rideid
        
        if ridemode == "2"{
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: RentalTrackRideViewController = storyboard.instantiateViewController(withIdentifier: "RentalTrackRideViewController") as! RentalTrackRideViewController
            nextController.Currentrideid = rideid
            self.present(nextController, animated: true, completion: nil)
            
        }else{

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController: TrackRideViewController = storyboard.instantiateViewController(withIdentifier: "TrackRideViewController") as! TrackRideViewController
        nextController.Currentrideid = rideid
        self.present(nextController, animated: true, completion: nil)
        
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
        
        if(GlobalVarible.Api == "rentalviewrideinfo"){
            
            rentalridedata = data as! RentalViewRideInfoModel
            
            if(rentalridedata.status == 1){
                
                GlobalVarible.RideId = (rentalridedata.details?.rentalBookingId)!
                
                
                
                
                // ApiManager.sharedInstance.protocolmain_Catagory = self
                //  ApiManager.sharedInstance.FindDirectionlatlng(pickLat: pickuplat,pickLng: pickuplong,DropLat : dropuplat ,DropLng: dropuplong)
                
                if ridestausvalue == "10" {
                    bookingdateridelater.text = "Booking Time :- " + datetimedata
                    
                    scheduledateridelater.text = "Schedule Time :- " + (rentalridedata.details?.bookingDate)! + " " + (rentalridedata.details?.bookingTime)!
                    
                }
                
                
                
                if ridestausvalue == "16" {
                    
                    completepickuptime.text = rentalridedata.details?.beginTime
                    completedropuptime.text = rentalridedata.details?.endTime
                    
                    rentaldistancetravel.text = (rentalridedata.details?.totalDistanceTravel)!
                    rentaltotaltime.text = rentalridedata.details?.totalTimeTravel
                    rentalpackagetext.text = "Package (" + (rentalridedata.details?.rentalPackageDistance)! + "Km for " + (rentalridedata.details?.rentalPackageHours)! + " hrs.)"
                    
                    rentalpackageprice.text = GlobalVarible.currencysymbol + " " + (rentalridedata.details?.rentalPackagePrice)!
                    
                    rentalextratimetraveltext.text = "Extra Distance Travel (" + (rentalridedata.details?.extraDistanceTravel)! + " Km)"
                    
                    rentalextratimetravelprice.text = GlobalVarible.currencysymbol + " " + (rentalridedata.details?.extraDistanceTravelCharge)!
                    
                    rentalextraestimatetimetext.text = "Extra Estimated time (" + (rentalridedata.details?.extraHoursTravel)! + "hrs.)"
                    rentalestimatetimeprice.text = GlobalVarible.currencysymbol + " " + (rentalridedata.details?.extraHoursTravelCharge)!
                    
                    
                    
                    
                    
                    rentaltotalpricetext.text = GlobalVarible.currencysymbol + " " + (rentalridedata.details?.totalamount)!
                    
                    rentalcouponcodetext.text = "Coupon Applied( " + (rentalridedata.details?.couponcode)! + " )"
                    
                    rentalcouponcodeprice.text = GlobalVarible.currencysymbol + " " + (rentalridedata.details?.couponprice!)!
                    
                    
                    
                    rentaltotalpayableamounttext.text = "Total Payable Amount (" + (rentalridedata.details?.paymentname)! + " )"
                    
                                      
                    rentaltotalpayableamout.text = GlobalVarible.currencysymbol + " " + (rentalridedata.details?.finalBillAmount)!
                    
                    
                    
                }
                
                
                
                completepickuplocation.text = rentalridedata.details!.pickupLocation
                Acceptedpickuplocation.text = rentalridedata.details?.pickupLocation
                ridelaterpickuplocation.text = rentalridedata.details?.pickupLocation
                ridelaterdroplocation.text = rentalridedata.details?.endLocation
                
                
                
                completedroplocation.text  = rentalridedata.details!.endLocation
                Accepteddroplocation.text = rentalridedata.details?.endLocation
                
                
                pickuplat = Double(rentalridedata.details!.pickupLat!)!
                pickuplong = Double(rentalridedata.details!.pickupLong!)!
                
                
                let url11 = "https://maps.googleapis.com/maps/api/staticmap?center=\(pickuplat!),\(pickuplong!)&zoom=15&size=400x300"
                
                let url1 = NSURL(string: url11)
                
                print(url11)
                
                self.completemapimageview!.af_setImage(withURL:
                    url1! as URL,
                                                       placeholderImage: UIImage(named: "dress"),
                                                       filter: nil,
                                                       imageTransition: .crossDissolve(1.0))
                
                
                self.Acceptedmapimageview!.af_setImage(withURL:
                    url1! as URL,
                                                       placeholderImage: UIImage(named: "dress"),
                                                       filter: nil,
                                                       imageTransition: .crossDissolve(1.0))
                
                
                
                self.ridelatermapimageview!.af_setImage(withURL:
                    url1! as URL,
                                                        placeholderImage: UIImage(named: "dress"),
                                                        filter: nil,
                                                        imageTransition: .crossDissolve(1.0))
                
                
                
                
                
                
                
                let driverratingvalue = rentalridedata.details?.userratingstar
                
                if driverratingvalue == ""{
                    print("hjjk")
                }else{
                    
                    completeratingview.rating = Float(driverratingvalue!)!
                    Acceptedratingview.rating = Float(driverratingvalue!)!
                }
                
                
                completecarname.text = rentalridedata.details?.carTypeName
                Acceptedcarname.text = rentalridedata.details?.carTypeName
                
                completeprice.text =  GlobalVarible.currencysymbol + " " + (rentalridedata.details?.finalBillAmount)!
                
                completedistance.text = (rentalridedata.details?.totalDistanceTravel)!
                completetime.text = rentalridedata.details?.totalTimeTravel
                
                //  donerideid = (mydatapage.details?.doneRideId)!
                
                
                // completetotalprice.text = GlobalVarible.currencysymbol + " " +  (mydatapage.details?.amount)!
                
                
                completedrivername.text = "  " + rentalridedata.details!.driverName!
                Accepteddrivername.text = "  " + rentalridedata.details!.driverName!
                
                
                completedriverimage.layer.borderWidth = 1
                completedriverimage.layer.masksToBounds = false
                completedriverimage.layer.borderColor = UIColor.black.cgColor
                completedriverimage.layer.cornerRadius = completedriverimage.frame.height/2
                completedriverimage.clipsToBounds = true
                
                
                Accepteddriverimage.layer.borderWidth = 1
                Accepteddriverimage.layer.masksToBounds = false
                Accepteddriverimage.layer.borderColor = UIColor.black.cgColor
                Accepteddriverimage.layer.cornerRadius = Accepteddriverimage.frame.height/2
                Accepteddriverimage.clipsToBounds = true
                
                
                
                let drivertypeimage = rentalridedata.details!.driverImage
                
                print(drivertypeimage!)
                
                if(drivertypeimage == ""){
                    completedriverimage.image = UIImage(named: "profileeee") as UIImage?
                    Accepteddriverimage.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    let newUrl = imageUrl + drivertypeimage!
                    // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                    print(newUrl)
                    
                    let url1 = NSURL(string: newUrl)
                    
                    
                    completedriverimage!.af_setImage(withURL:
                        url1! as URL,
                                                     placeholderImage: UIImage(named: "dress"),
                                                     filter: nil,
                                                     imageTransition: .crossDissolve(1.0))
                    
                    Accepteddriverimage!.af_setImage(withURL:
                        url1! as URL,
                                                     placeholderImage: UIImage(named: "dress"),
                                                     filter: nil,
                                                     imageTransition: .crossDissolve(1.0))
                    
                }
                
                
                let cartypeimage = rentalridedata.details!.carTypeImage
                
                
                
                if(cartypeimage == ""){
                    completecarimage.image = UIImage(named: "profileeee") as UIImage?
                    Acceptedcarimage.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    let newUrl = imageUrl + cartypeimage!
                    //  let url = "http://apporio.co.uk/apporiotaxi/\(cartypeimage!)"
                    print(newUrl)
                    
                    let url1 = NSURL(string: newUrl)
                    completecarimage!.af_setImage(withURL:
                        url1! as URL,
                                                  placeholderImage: UIImage(named: "dress"),
                                                  filter: nil,
                                                  imageTransition: .crossDissolve(1.0))
                    Acceptedcarimage!.af_setImage(withURL:
                        url1! as URL,
                                                  placeholderImage: UIImage(named: "dress"),
                                                  filter: nil,
                                                  imageTransition: .crossDissolve(1.0))
                    
                }
                
                
                
                
            }else{
                
                print("Hello")
                
                
            }
            
            
            
        }
        
        if(GlobalVarible.Api == "normalviewrideinfo"){
            
            
            
            mydatapage = data as! NormalViewRideInfoModel
            
            if(mydatapage.status == 1){
                
                GlobalVarible.RideId = (mydatapage.details?.rideId)!
                
                dropuplat = Double(mydatapage.details!.dropLat!)!
                dropuplong = Double(mydatapage.details!.dropLong!)!
                
                pickuplat = Double(mydatapage.details!.pickupLat!)!
                pickuplong = Double(mydatapage.details!.pickupLong!)!
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.FindDirectionlatlng(pickLat: pickuplat,pickLng: pickuplong,DropLat : dropuplat ,DropLng: dropuplong)
                
                 if ridestausvalue == "1" {
                bookingdateridelater.text = "Booking Time :- " + datetimedata
                
               scheduledateridelater.text = "Schedule Time :- " + (mydatapage.details?.laterDate)! + " " + (mydatapage.details?.laterTime)!

                }
                
                if ridestausvalue == "7" {
                    
                    completepickuptime.text = mydatapage.details?.beginTime
                    completedropuptime.text = mydatapage.details?.endTime
                    completedistancetravel.text = (mydatapage.details?.distance)!
                    completedistancefare.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.amount)!
                    completeridetimecharges.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.rideTimePrice)!
                    completewaitingcharge.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.waitingPrice)!
                    
                    completecoupontext.text = "Coupon Applied( " + (mydatapage.details?.couponCode)! + " )"
                    
                    completecouponprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.coupanPrice)!
                    
                    completepeaktimechargestext.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.peaktimecharges)!
                    
                    completenighttimechargestext.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.nighttimecharges)!
                  
                    
                   // rentalcouponcodeprice.text = GlobalVarible.currencysymbol + " " + "- - -"

                    
                    completetotalprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.totalAmount)!
                    
                    completepaymentmethod.text = mydatapage.details?.paymentname
                    
                    completepaymentmethodwithprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.details?.totalAmount)!
                    
                    
                }
                
                
                
                completepickuplocation.text = mydatapage.details!.pickupLocation
                Acceptedpickuplocation.text = mydatapage.details?.pickupLocation
                ridelaterpickuplocation.text = mydatapage.details?.pickupLocation
                ridelaterdroplocation.text = mydatapage.details?.dropLocation
                
                
                
                completedroplocation.text  = mydatapage.details!.dropLocation
                Accepteddroplocation.text = mydatapage.details?.dropLocation
                
                let driverratingvalue = mydatapage.details?.userratingstar
                
                if driverratingvalue == ""{
                    print("hjjk")
                }else{
                    
                    completeratingview.rating = Float(driverratingvalue!)!
                    Acceptedratingview.rating = Float(driverratingvalue!)!
                }
                
                
                completecarname.text = mydatapage.details?.carTypeName
                
                Acceptedcarname.text = mydatapage.details?.carTypeName
                
                completeprice.text =  GlobalVarible.currencysymbol + " " + (mydatapage.details?.totalAmount)!
                
                completedistance.text = (mydatapage.details?.distance)!
                completetime.text = mydatapage.details?.time
                
                donerideid = (mydatapage.details?.rideId)!
                
                //  donerideid = (mydatapage.details?.doneRideId)!
                
                
                // completetotalprice.text = GlobalVarible.currencysymbol + " " +  (mydatapage.details?.amount)!
                
                
                completedrivername.text = "  " + mydatapage.details!.driverName!
                Accepteddrivername.text = "  " + mydatapage.details!.driverName!
                
                
                completedriverimage.layer.borderWidth = 1
                completedriverimage.layer.masksToBounds = false
                completedriverimage.layer.borderColor = UIColor.black.cgColor
                completedriverimage.layer.cornerRadius = completedriverimage.frame.height/2
                completedriverimage.clipsToBounds = true
                
                
                Accepteddriverimage.layer.borderWidth = 1
                Accepteddriverimage.layer.masksToBounds = false
                Accepteddriverimage.layer.borderColor = UIColor.black.cgColor
                Accepteddriverimage.layer.cornerRadius = Accepteddriverimage.frame.height/2
                Accepteddriverimage.clipsToBounds = true
                
                
                
                let drivertypeimage = mydatapage.details!.driverImage
                
                print(drivertypeimage!)
                
                if(drivertypeimage == ""){
                    completedriverimage.image = UIImage(named: "profileeee") as UIImage?
                    Accepteddriverimage.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    let newUrl = imageUrl + drivertypeimage!
                    // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                    print(newUrl)
                    
                    let url1 = NSURL(string: newUrl)
                    
                    
                    completedriverimage!.af_setImage(withURL:
                        url1! as URL,
                                                     placeholderImage: UIImage(named: "dress"),
                                                     filter: nil,
                                                     imageTransition: .crossDissolve(1.0))
                    
                    Accepteddriverimage!.af_setImage(withURL:
                        url1! as URL,
                                                     placeholderImage: UIImage(named: "dress"),
                                                     filter: nil,
                                                     imageTransition: .crossDissolve(1.0))
                    
                }
                
                
                let cartypeimage = mydatapage.details!.carTypeImage
                
                
                
                if(cartypeimage == ""){
                    completecarimage.image = UIImage(named: "profileeee") as UIImage?
                    Acceptedcarimage.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    let newUrl = imageUrl + cartypeimage!
                    //  let url = "http://apporio.co.uk/apporiotaxi/\(cartypeimage!)"
                    print(newUrl)
                    
                    let url1 = NSURL(string: newUrl)
                    completecarimage!.af_setImage(withURL:
                        url1! as URL,
                                                  placeholderImage: UIImage(named: "dress"),
                                                  filter: nil,
                                                  imageTransition: .crossDissolve(1.0))
                    Acceptedcarimage!.af_setImage(withURL:
                        url1! as URL,
                                                  placeholderImage: UIImage(named: "dress"),
                                                  filter: nil,
                                                  imageTransition: .crossDissolve(1.0))
                    
                }
                
                
                
                
            }else{
                
                print("Hello")
                
                
            }
            
            
            
        }
        
        
        if(GlobalVarible.Api == "mailinvoice"){
            
            mailinvoicedata = data as! MailInvoiceModel
            
            if (mailinvoicedata.result == 1){
                
                showalert(message: mailinvoicedata.msg!)
                
            }else{
                
                showalert(message: mailinvoicedata.msg!)
                
            }
            
            
            
            
        }
        
        if(GlobalVarible.Api == "directionapiresult"){
            
            newgoogledistancemodel = data as! NewGoogleDistanceModel
            
            if(newgoogledistancemodel.status == "OK"){
                
                latroute1.removeAll()
                longroute1.removeAll()
                
                
                
                
                let data1 = newgoogledistancemodel.routes![0].legs![0].steps?.count
                
                let data2 = Int(data1!)
                
                // let data1 = data["routes"]![0]["legs"]!![0]["steps"]!!.count
                
                print(data2)
                
                for i in 0..<data2 {
                    
                    let intvaluedata = Double(newgoogledistancemodel.routes![0].legs![0].steps![i].startLocation!.lat!)
                    
                    latroute1.append(Double(newgoogledistancemodel.routes![0].legs![0].steps![i].startLocation!.lat!))
                    
                    longroute1.append(Double(newgoogledistancemodel.routes![0].legs![0].steps![i].startLocation!.lng!))
                    
                    
                    
                    //  latroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![i]["start_location"]!!["lat"] as! Double)
                    //   longroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![i]["start_location"]!!["lng"] as! Double)
                    
                    
                }
                
                
                latroute1.append(Double(newgoogledistancemodel.routes![0].legs![0].steps![data2 - 1].endLocation!.lat!))
                longroute1.append(Double(newgoogledistancemodel.routes![0].legs![0].steps![data2 - 1].endLocation!.lng!))
                
                // latroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![data1 - 1]["end_location"]!!["lat"] as! Double)
                //  longroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![data1 - 1]["end_location"]!!["lng"] as! Double)
                
                print(latroute1)
                print(longroute1)
                
                
                let phonewidth = Int(self.view.frame.width) + 100
                let phoneheight = 260
                
                
                
                for i in 0..<latroute1.count{
                    
                    
                    
                    value = value.appending(String(latroute1[i]) + "," + String(longroute1[i]) + "|")
                    
                    
                    
                }
                
                
                
                
                let truncated = value.substring(to: value.index(before: value.endIndex))
                
                
                
                print(truncated)
                
                let arraycount = latroute1.count
                
                print(arraycount)
                
                
                let url11 = "http://maps.googleapis.com/maps/api/staticmap?size=\(phonewidth)x\(phoneheight)&path=color:0x000000|weight:2|\(truncated)&sensor=false&markers=icon:http://apporio.co.uk/triwl/s3.png|\(pickuplat!),\(pickuplong!)&markers=icon:http://apporio.co.uk/triwl/s2.png|\(dropuplat!),\(dropuplong!)"
                
                
                print(url11)
                
                let url12 = url11.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                
                
                
                let url15 = NSURL(string: url12)
                
                
                
                self.completemapimageview!.af_setImage(withURL:
                    url15! as URL,
                                                       placeholderImage: UIImage(named: "dress"),
                                                       filter: nil,
                                                       imageTransition: .crossDissolve(1.0))
                
                self.Acceptedmapimageview!.af_setImage(withURL:
                    url15! as URL,
                                                       placeholderImage: UIImage(named: "dress"),
                                                       filter: nil,
                                                       imageTransition: .crossDissolve(1.0))
                
                self.ridelatermapimageview!.af_setImage(withURL:
                    url15! as URL,
                                                        placeholderImage: UIImage(named: "dress"),
                                                        filter: nil,
                                                        imageTransition: .crossDissolve(1.0))
                
                
                
                
                
            }
            
        }
        
        
    }
    
    
    
}
