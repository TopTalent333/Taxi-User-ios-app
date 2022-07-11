//
//  NewPaymentViewController.swift
//  Apporio Taxi
//
//  Created by AppOrio on 11/09/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import StarryStars
import SwiftyJSON

class NewPaymentViewController: UIViewController,MainCategoryProtocol,RatingViewDelegate {
    
    var mydatapage :DoneRideModel!
    var mydata : CompletePayment!
    var paydata : PayCardModel!
    @IBOutlet weak var lblAmount: UILabel!
    var wallet: WalletModel!
   
    
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    var provider: OPPPaymentProvider?
    var checkoutID : String!
    
    @IBOutlet weak var cardDeducted: UILabel!
    
    @IBOutlet weak var driverdetailsorratingview: UIView!
    
    @IBOutlet weak var hiddenview: UIView!
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var bycashimage: UIImageView!
    
    @IBOutlet weak var bypaypalimage: UIImageView!
 
    @IBOutlet weak var bywalletimage: UIImageView!
   
    var resultText = ""
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentProduction {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    static let sharedInstance = NewPaymentViewController()
    
    let imageUrl = API_URL.imagedomain

    #if HAS_CARDIO
    // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
    // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
    // for more details.
    var acceptCreditCards: Bool = true {
    didSet {
    payPalConfig.acceptCreditCards = acceptCreditCards
    }
    }
    #else
    var acceptCreditCards: Bool = false {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    #endif

    @IBOutlet weak var topmapimageview: UIImageView!
    
    @IBOutlet weak var toptotalfareprice: UILabel!
    
    @IBOutlet weak var toptotaldistancetext: UILabel!
    
    @IBOutlet weak var toptotalridetimetext: UILabel!
    
//    @IBOutlet weak var walletdeductedprice: UILabel!
    
    @IBOutlet weak var toppickuplocationtext: UILabel!
    
    @IBOutlet weak var topdroplocationtext: UILabel!
    
    @IBOutlet weak var totaldistanceprice: UILabel!
    
    @IBOutlet weak var ridetimechargesprice: UILabel!
    
    @IBOutlet weak var waitingchargeprice: UILabel!
    
    @IBOutlet weak var couponcodetext: UILabel!
    
    @IBOutlet weak var netfareprice: UILabel!
    
    @IBOutlet weak var nighttimechargesprice: UILabel!
    
    @IBOutlet weak var peaktimechargesprice: UILabel!
    
    @IBOutlet weak var couponcodeprice: UILabel!

    @IBOutlet weak var cashamountpaidview: UIView!
    
    @IBOutlet weak var amountpaidview: UIView!
    
    @IBOutlet weak var selectpaymentoptionview: UIView!
    
    @IBOutlet weak var selectpaymentoptionwithpaypalview: UIView!
    
    @IBOutlet weak var showcashprice: UILabel!
    
    @IBOutlet weak var showamountpaidprice: UILabel!
    
    @IBOutlet weak var ratingview: RatingView!
    
    @IBOutlet weak var drivernametext: UILabel!
    
    @IBOutlet weak var driverimageview: UIImageView!
    
    @IBOutlet weak var okbtnview: UIView!
    
    @IBOutlet weak var commentview: UIView!
    
    @IBOutlet weak var commenttextview: UITextView!

    var creditcardrideid = ""
    
    var donerideid = ""
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
    
    var DRIVERID = ""
    
    var userselectpaymentoption = ""
    
    var selectpaymentstatus = ""
    
    var currentrideid = ""
    
     var ratingStar = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        
         GlobalVarible.rideendstopupdatelocation = 1
        
        
        driverdetailsorratingview.layer.shadowColor = UIColor.gray.cgColor
        driverdetailsorratingview.layer.shadowOpacity = 1
        driverdetailsorratingview.layer.shadowOffset = CGSize(width: 0, height: 2)
        driverdetailsorratingview.layer.shadowRadius = 3

        
        
        driverimageview.layer.cornerRadius =  driverimageview.frame.width/2
        driverimageview.clipsToBounds = true
        driverimageview.layer.borderWidth = 1
        driverimageview.layer.borderColor = UIColor.black.cgColor
        

        hiddenview.isHidden = true
        
        
        self.commentview.layer.borderWidth = 1.0
        self.commentview.layer.cornerRadius = 4

        
        ratingview.editable = true
        ratingview.delegate = self
        
        payPalConfig.acceptCreditCards = acceptCreditCards
        payPalConfig.merchantName = ""
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full") as URL?
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")! as URL
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages[0]
        
        payPalConfig.payPalShippingAddressOption = .payPal
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ViewDoneRide(RIDEID: currentrideid)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if GlobalVarible.PeachPaymentVar == 0 {
            
        }
            
        else{
            GlobalVarible.PeachPaymentVar = 0
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ViewDoneRide(RIDEID: currentrideid)
        }
    }
    

    
    func ratingView(_ ratingView: RatingView, didChangeRating newRating: Float) {
        print("newRating: \(newRating)")
        let rating = newRating
        // var  ratingValue = String(rating)
        ratingStar = String(rating)
        GlobalVarible.RatingValue =  String(rating)
        
    }
    
    
    // MARK: Future Payments
    
    
    
    @IBAction func authorizeFuturePaymentsAction(sender: AnyObject) {
    }
    
    
    
    
    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
        print("PayPal Future Payment Authorization Canceled")
        futurePaymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable : Any]) {
        print("PayPal Future Payment Authorization Success!")
        // send authorization to your server to get refresh token.
        futurePaymentViewController.dismiss(animated: true, completion: { () -> Void in
            self.resultText = futurePaymentAuthorization.description
            self.showSuccess()
        })
    }
    
    
    // MARK: Profile Sharing
    
    @IBAction func authorizeProfileSharingAction(sender: AnyObject) {
        let scopes = [kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]
    }
    // PayPalProfileSharingDelegate
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable : Any]) {
        print("PayPal Profile Sharing Authorization Success!")
        
        // send authorization to your server
        
        profileSharingViewController.dismiss(animated: true, completion: { () -> Void in
            self.resultText = profileSharingAuthorization.description
            
            
            self.showSuccess()
        })
        
    }
    
    
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        print("PayPal Profile Sharing Authorization Canceled")
        
        profileSharingViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
    func showSuccess() {
        self.dismiss(animated: true, completion: nil)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelay(2.0)
        
        UIView.commitAnimations()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelbtn_click(_ sender: Any) {
        hiddenview.isHidden = true
        
    }
    
    @IBAction func hiddenviewwalletselect(_ sender: Any) {
      
        bycashimage.image = UIImage(named: "Circle Thin-35 (1)")
        bypaypalimage.image = UIImage(named: "Circle Thin-35 (1)")
        bywalletimage.image = UIImage(named: "Circled Dot-35 (1)")
        
        hiddenview.isHidden = true
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.WalletApi(Rideid: GlobalVarible.RideId, TotalAmt: GlobalVarible.TotalPayableamount)
        
        /*ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ConfirmPayment(OrderId: donerideid, UserId: Userid!,
        PaymentId: "1", PaymentMethod: "Wallet", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")*/
    
    
    }
    
    @IBAction func hiddenviewcashselect(_ sender: Any) {
        
        bycashimage.image = UIImage(named: "Circled Dot-35 (1)")
        bypaypalimage.image = UIImage(named: "Circle Thin-35 (1)")
        bywalletimage.image = UIImage(named: "Circle Thin-35 (1)")
        
        hiddenview.isHidden = true
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ConfirmPayment(OrderId: donerideid, UserId: Userid!,
            PaymentId: "1", PaymentMethod: "Cash", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
        
    }
    
   
    @IBAction func hiddenviewpaypalselect(_ sender: Any) {


        bypaypalimage.image = UIImage(named: "Circled Dot-35 (1)")
        bycashimage.image = UIImage(named: "Circle Thin-35 (1)")
        bywalletimage.image = UIImage(named: "Circle Thin-35 (1)")
        
        hiddenview.isHidden = true
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let revealViewController = storyBoard.instantiateViewController(withIdentifier: "PeachPaymentViewController") as! PeachPaymentViewController
        revealViewController.checkoptionvalue = 1
        self.present(revealViewController, animated:true, completion:nil)
        

        
        
       /* if(GlobalVarible.TotalPayableamount == "0.00"){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(OrderId: donerideid, UserId: Userid!, PaymentId: "1", PaymentMethod: "Paypal", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
            
            
        }else{
            
            let decimalTotalamount = NSDecimalNumber(string: GlobalVarible.TotalPayableamount)
            
            print(decimalTotalamount)
            
            let payment = PayPalPayment(amount: decimalTotalamount, currencyCode: "GBP", shortDescription: "Pay", intent: .sale)
            
            
            if (payment.processable) {
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                present(paymentViewController!, animated: true, completion: nil)
            }
            else {
                
                print("Payment not processable: \(payment)")
            }
            
        }*/

        
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 0
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        return cell
        
    }
    
    
    @IBAction func selectpaymentbtnoption_click(_ sender: Any) {
        
        hiddenview.isHidden = false
    }
    
    @IBAction func selectpaypaloptionbtn_click(_ sender: Any) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let revealViewController = storyBoard.instantiateViewController(withIdentifier: "PeachPaymentViewController") as! PeachPaymentViewController
        
        self.present(revealViewController, animated:true, completion:nil)
        
        revealViewController.checkoptionvalue = 1  
        
       /* if(GlobalVarible.TotalPayableamount == "0.00"){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(OrderId: donerideid, UserId: Userid!, PaymentId: "1", PaymentMethod: "Paypal", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
            
            
        }else{
            
            let decimalTotalamount = NSDecimalNumber(string: GlobalVarible.TotalPayableamount)
            
            print(decimalTotalamount)
            
            let payment = PayPalPayment(amount: decimalTotalamount, currencyCode: "GBP", shortDescription: "Pay", intent: .sale)
            
            
            if (payment.processable) {
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                present(paymentViewController!, animated: true, completion: nil)
            }
            else {
                
                print("Payment not processable: \(payment)")
            }
            
        }*/
        
    }

    
    @IBAction func selectpaymentoptionbtnwithpaypal_click(_ sender: Any) {
        
         hiddenview.isHidden = false
    }
    
    @IBAction func okbtn_click(_ sender: Any) {
        
        GlobalVarible.UserDropLocationText = NSLocalizedString("No drop off point", comment: "")
        GlobalVarible.UserDropLat = 0.0
        GlobalVarible.UserDropLng = 0.0
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RatingSubmitbtn(UserId: Userid!, DriverId: GlobalVarible.DRIVERID , RatingStar: ratingStar,RideId: GlobalVarible.RideId,Comment: commenttextview.text!)
        
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
            
            if(GlobalVarible.Api == "walletmodelapi") {
            wallet = data as! WalletModel
            
                if(wallet.result == 1) {
                    ApiManager.sharedInstance.protocolmain_Catagory = self
                    ApiManager.sharedInstance.ViewDoneRide(RIDEID: donerideid)
                
                }
                else{
                    self.showalert(message: wallet.msg!)
                
                }
            }
            if(GlobalVarible.Api == "CONFIRMPAYMENT"){
                
                mydata = data as! CompletePayment
                
                if(mydata.result == 1){
                    amountpaidview.isHidden = false
                    selectpaymentoptionview.isHidden = true
                    okbtnview.isHidden = false
                    self.showalert(message: "R \(GlobalVarible.TotalPayableamount) was deducted from your card")
                }else{
                    self.showalert(message: mydata.msg!)
                }
            }

            
            if(GlobalVarible.Api == "NormalRating"){
                
                if(JSON(data)["result"] == 1){
                    
                                     
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: {
                        GlobalVarible.viewcontrollerself.viewDidLoad()
                    })
                    
                    
                    
                }else{
                    
                    self.showalert(message: NSLocalizedString("Please Try Again!!", comment: ""))
                    
                    
                }
                
            }

            
            if(GlobalVarible.Api == "DoneRideInformation"){
                
                mydatapage = data as! DoneRideModel
                
                if(mydatapage.result == 1){
                    
                    donerideid = (mydatapage.msg?.doneRideId)!
                    
                    GlobalVarible.RideId = (mydatapage.msg?.rideId)!
                    
                    GlobalVarible.TotalPayableamount = (mydatapage.msg!.totalpayableamount)!
                    
                    GlobalVarible.DRIVERID = (mydatapage.msg!.driverId)!
                    
                    topdroplocationtext.text = mydatapage.msg?.endLocation
                    
                    toppickuplocationtext.text = mydatapage.msg?.beginLocation
                    
                    toptotalfareprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg!.totalpayableamount)!
                    
                    toptotaldistancetext.text = "Total Distance: " + (mydatapage.msg!.distance)!
                    
                    totaldistanceprice.text =  GlobalVarible.currencysymbol + " " + (mydatapage.msg?.amount)!
                    
                     toptotalridetimetext.text = "Total Ride Time: " + (mydatapage.msg?.rideTime)!
                    
                    ridetimechargesprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.rideTimePrice)!
                    
                    waitingchargeprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.waitingPrice)!
                    
                    couponcodetext.text = "Coupon (" + (mydatapage.msg?.couponsCode)! + " )"
                    
                    couponcodeprice.text =  GlobalVarible.currencysymbol + " " + (mydatapage.msg?.couponsPrice)!
                    
                    netfareprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.totalAmount)!
                    
                    
                    peaktimechargesprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.peakTimeCharge)!
                    
                    nighttimechargesprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.nightTimeCharge)!
                    
                    userselectpaymentoption = mydatapage.msg!.paymentOptionId!
                    
                    selectpaymentstatus = (mydatapage.msg?.paymentStatus!)!
                    
                    
                    creditcardrideid = (mydatapage.msg?.rideId)!
                    
                    drivernametext.text = "Rate " + (mydatapage.msg?.driverName)!
                    
                    let driverstatusimage = mydatapage.msg?.driverImage
                    
                    if driverstatusimage == ""{
                        driverimageview.image = UIImage(named: "profileeee") as UIImage?
                    }else{
                        let newUrl = imageUrl + driverstatusimage!
                        let url = URL(string: newUrl)
                        driverimageview.af_setImage(withURL:
                            url! as URL,
                                              placeholderImage: UIImage(named: "dress"),
                                              filter: nil,
                                              imageTransition: .crossDissolve(1.0))
                    }
                    
                    
                    
                    let newUrl = mydatapage.msg?.rideImage!
                    
                    
                    
                     let url12 = newUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    
                    
                    let url15 = NSURL(string: url12!)
                    
                    topmapimageview!.af_setImage(withURL:
                        url15! as URL,
                                              placeholderImage: UIImage(named: "dress"),
                                              filter: nil,
                                              imageTransition: .crossDissolve(1.0))
                    

//                walletdeductedprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.walletDeductedAmount!)!
                   
               showcashprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.totalpayableamount)!
                    
                showamountpaidprice.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.totalpayableamount)!
                    
                    
                    if userselectpaymentoption == "1"{
                        
                        cashamountpaidview.isHidden = false
                        amountpaidview.isHidden = true
                        selectpaymentoptionview.isHidden = true
                        selectpaymentoptionwithpaypalview.isHidden = true
                        okbtnview.isHidden = false
                       
                        
                    
                    
                    }
                    if userselectpaymentoption == "2"{
                        
                        cashamountpaidview.isHidden = true
                        
                        selectpaymentoptionview.isHidden = true
                       
                        
                       
                       /* if(selectpaymentstatus == "0"){
                            amountpaidview.isHidden = true
                            selectpaymentoptionview.isHidden = false
                            okbtnview.isHidden = true
                            
                            
                        }else{
                            amountpaidview.isHidden = false
                            selectpaymentoptionview.isHidden = true
                            okbtnview.isHidden = false
                        }*/
                        
                        
                        if(selectpaymentstatus == "0"){
                            amountpaidview.isHidden = true
                            selectpaymentoptionwithpaypalview.isHidden = false
                            okbtnview.isHidden = true
                            
                            self.showalert(message: (mydatapage.msg?.paymentFaliedMessage)!)
                            
                            
                        }else{
                            amountpaidview.isHidden = false
                            selectpaymentoptionwithpaypalview.isHidden = true
                            okbtnview.isHidden = false
                        }
                    
                    }
                    if userselectpaymentoption == "3"{
                        cashamountpaidview.isHidden = true
                        selectpaymentoptionwithpaypalview.isHidden = true
                        amountpaidview.isHidden = false
                        selectpaymentoptionview.isHidden = true
                        lblAmount.text = "Card deducted"
                        cardDeducted.text = "R "+GlobalVarible.TotalPayableamount
                        okbtnview.isHidden = false
                    }
                    if userselectpaymentoption == "4"{
                        cashamountpaidview.isHidden = true
                        selectpaymentoptionwithpaypalview.isHidden = true
                        
                        if(selectpaymentstatus == "0"){
                            amountpaidview.isHidden = true
                            selectpaymentoptionview.isHidden = false
                            okbtnview.isHidden = true
                            
                             self.showalert(message: (mydatapage.msg?.paymentFaliedMessage)!)
                            
                        }else{
                            amountpaidview.isHidden = false
                            selectpaymentoptionview.isHidden = true
                            okbtnview.isHidden = false
                        }

                    }
                }else{
                    
                    print("HelloRating")
                }
                
            }

        }
    
}
