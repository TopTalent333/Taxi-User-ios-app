//
//  RecieptViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 25/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON


class RecieptViewController: UIViewController,MainCategoryProtocol,PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate {
    
    var mydatapage :DoneRideModel!
    var mydata : CompletePayment!
    var paydata : PayCardModel!
    
    
    var userselectpaymentoption = ""
    
    var currentrideid = ""
    
     
    
    let imageUrl = API_URL.imagedomain
    
    
    var i = 0
    
    var resultText = ""
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentProduction {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    static let sharedInstance = RecieptViewController()
    
    
    @IBOutlet weak var nighttimechargestext: UILabel!
    
    @IBOutlet weak var peaktimechargestext: UILabel!
    
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
    
    
    
    var creditcardrideid = ""
    
    var donerideid = ""
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
    
    var DRIVERID = ""
    

    @IBOutlet weak var totalpayableview: UIView!

    @IBOutlet weak var usetpickuplocationlabel: UILabel!
    
    @IBOutlet weak var userdroplocationlabel: UILabel!
    
    
    @IBOutlet weak var tripdetailsview: UIView!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var totalpayableamouttext: UILabel!
    
    @IBOutlet weak var totaldistancelabel: UILabel!
    
    @IBOutlet weak var farelabeltext: UILabel!
    
    @IBOutlet weak var ridetimechargelabel: UILabel!
    
    
    @IBOutlet weak var waitinglabel: UILabel!
    
    @IBOutlet weak var maincouponlabel: UILabel!
    
    @IBOutlet weak var netfaretextlabel: UILabel!
    
    @IBOutlet weak var coupontextlabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         GlobalVarible.rideendstopupdatelocation = 1
        
        tripdetailsview.layer.shadowColor = UIColor.gray.cgColor
        tripdetailsview.layer.shadowOpacity = 1
        tripdetailsview.layer.shadowOffset = CGSize(width: 0, height: 3)
       tripdetailsview.layer.shadowRadius = 5
        
        totalpayableview.layer.shadowColor = UIColor.gray.cgColor
        totalpayableview.layer.shadowOpacity = 1
        totalpayableview.layer.shadowOffset = CGSize(width: 0, height: 3)
        totalpayableview.layer.shadowRadius = 5
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Receiptmethod),
            name: NSNotification.Name(rawValue: "recieptscreen"),
            object: nil)



        
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
    
    
     func Receiptmethod(notification: NSNotification){
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ViewDoneRide(RIDEID: currentrideid)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // self.mainview.frame.size.height = 700
        self.scrollview.frame = self.scrollview.bounds
        self.scrollview.contentSize.height = 650
        self.scrollview.contentSize.width = 0
        
    }
    

    
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            
            let data = JSON(completedPayment.confirmation)
            print(data)
            let datatoParse = PayPalModel(json: data)
            GlobalVarible.CreateTime =  (datatoParse.response?.createTime!)!
            GlobalVarible.State = (datatoParse.response?.state!)!
            GlobalVarible.PaypalId = (datatoParse.response?.internalIdentifier!)!
            GlobalVarible.Intent = (datatoParse.response?.intent!)!
            self.resultText = completedPayment.description
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(OrderId: self.donerideid, UserId: self.Userid!, PaymentId: GlobalVarible.PaypalId, PaymentMethod: "Paypal", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CreateTime, PaymentStatus: GlobalVarible.State)
            // self.showSuccess()
        })
    }
    
    
    
    // MARK: Future Payments
    
    
    
    @IBAction func authorizeFuturePaymentsAction(sender: AnyObject) {
        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: payPalConfig, delegate: self)
        present(futurePaymentViewController!, animated: true, completion: nil)
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
        let profileSharingViewController = PayPalProfileSharingViewController(scopeValues: NSSet(array: scopes) as Set<NSObject>, configuration: payPalConfig, delegate: self)
        present(profileSharingViewController!, animated: true, completion: nil)
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
    
    

    

    @IBAction func makepaymentbtnclick(_ sender: Any) {
        
        
        
        if(userselectpaymentoption == "1"){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(OrderId: donerideid, UserId: Userid!, PaymentId: "1", PaymentMethod: "Cash", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
            
            
        }else if(userselectpaymentoption == "2"){
            
            
            if(GlobalVarible.TotalPayableamount == "0.00"){
                
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
            
            
            }
            
        }else if(userselectpaymentoption == "3"){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.PayPaymentCard(RideId: creditcardrideid, Amount: GlobalVarible.TotalPayableamount)
            
            
        }else if(userselectpaymentoption == "4"){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(OrderId: donerideid, UserId: Userid!, PaymentId: "1", PaymentMethod: "Wallet", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
            
            
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
    
    
    func showalert1(message:String)  {
        
        DispatchQueue.main.async(execute: {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action) in
                
               // self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: MapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                
                if let window = self.view.window{
                    window.rootViewController = nextController
                }
                

                
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
        
        
        if(GlobalVarible.Api == "DoneRideInformation"){
            
            mydatapage = data as! DoneRideModel
            
            if(mydatapage.result == 1){
                
                donerideid = (mydatapage.msg?.doneRideId)!
                
                GlobalVarible.RideId = (mydatapage.msg?.rideId)!
                
                GlobalVarible.TotalPayableamount = (mydatapage.msg!.totalAmount)!
                
                GlobalVarible.DRIVERID = (mydatapage.msg!.driverId)!
                
                userdroplocationlabel.text = mydatapage.msg?.endLocation
                
                usetpickuplocationlabel.text = mydatapage.msg?.beginLocation
                
                totalpayableamouttext.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg!.totalAmount)!
                
                totaldistancelabel.text = (mydatapage.msg!.distance)!
                
                farelabeltext.text =  GlobalVarible.currencysymbol + " " + (mydatapage.msg?.amount)!
                
                ridetimechargelabel.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.rideTimePrice)!
                
                waitinglabel.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.waitingPrice)!
                
                maincouponlabel.text = "Coupon (" + (mydatapage.msg?.couponsCode)! + " )"
                
                coupontextlabel.text =  GlobalVarible.currencysymbol + " " + (mydatapage.msg?.couponsPrice)!
                
                netfaretextlabel.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.totalAmount)!
                
                
                peaktimechargestext.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.peakTimeCharge)!
                
                nighttimechargestext.text = GlobalVarible.currencysymbol + " " + (mydatapage.msg?.nightTimeCharge)!
                
                userselectpaymentoption = mydatapage.msg!.paymentOptionId!
                
                
                creditcardrideid = (mydatapage.msg?.rideId)!
                
                
                
                              
            }else{
                
                print("HelloRating")
                
            }
            
            
            
            
        }
        
        
        if(GlobalVarible.Api == "CONFIRMPAYMENT"){
            
            mydata = data as! CompletePayment
            
            if(mydata.result == 1){
                // makepayment.userInteractionEnabled = false
                // Viewinvoice.userInteractionEnabled = true
                
                UserDefaults.standard.setValue("0", forKey:"firebaseride_status")
                GlobalVarible.checkRideId = "0"
               GlobalVarible.checkridestatus = "0"
                
                let invoiceno = mydata.details?.orderId
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let invoiceViewController = storyBoard.instantiateViewController(withIdentifier: "InvoiceViewController") as! InvoiceViewController
                invoiceViewController.invoicenumber = invoiceno!
                invoiceViewController.invoicedata = self.mydatapage
                
                self.present(invoiceViewController, animated:true, completion:nil)
                
                
            }else{
                
                self.showalert1(message: mydata.msg!)
                
                
                
            }
            
            
        }
        
        if(GlobalVarible.Api == "paycard"){
            paydata = data as! PayCardModel
            
            let completepaymentid = paydata.paymentId
            
            if(paydata.result == 1){
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.ConfirmPayment(OrderId: donerideid, UserId: Userid!, PaymentId: completepaymentid!, PaymentMethod: "Credit Card", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
                
                
                
            }else{
                
                self.showalert(message: paydata.msg!)
            }
            
            
            
        }

        
        
    }
  
}
