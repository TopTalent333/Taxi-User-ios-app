//
//  AddMoneyViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 15/07/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import Stripe

class AddMoneyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MainCategoryProtocol,CardIOPaymentViewControllerDelegate {
    
    @IBOutlet weak var mainview: UIView!
    
    var savedata : SaveCardModel!
    var carddata : CardDetailsModel!
    var addmoneydata : AddMoneyModel!
    
    
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    
    
    var SIZE = 0
    
    var toastLabel : UILabel!

    var enteramountvalue = ""
    
    @IBOutlet weak var carddetailstableview: UITableView!
    
    
    @IBOutlet weak var currencylabeltext: UILabel!
    
    
    @IBOutlet weak var firstbtn: UIButton!
    
    @IBOutlet weak var secondbtn: UIButton!
    
    @IBOutlet weak var thirdbtn: UIButton!
    @IBOutlet weak var enteramounttext: UITextField!
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
    var newGeneratedCardName = ""
    var newGeneratedCardNumber = ""
    var newGeneratedCardExpiryMonth = ""
    var newGeneratedCardExpiryYear = ""
    var newGeneratedCardCv = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        carddetailstableview.isHidden = true
        
        
        currencylabeltext.text = GlobalVarible.currencysymbol
        
        self.firstbtn.setTitle(GlobalVarible.currencysymbol + " 100", for: .normal)
        
         self.secondbtn.setTitle(GlobalVarible.currencysymbol + " 200", for: .normal)
        
         self.thirdbtn.setTitle(GlobalVarible.currencysymbol + " 300", for: .normal)
        
       
        
                
        
        toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-300, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(toastLabel)
        toastLabel.text =  NSLocalizedString("No Card Added!!", comment: "")
        
        toastLabel.isHidden = true
        

        
        mainview.layer.shadowColor = UIColor.gray.cgColor
        mainview.layer.shadowOpacity = 1
        mainview.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainview.layer.shadowRadius = 2
        
        
        self.firstbtn.layer.borderWidth = 1.0
        self.firstbtn.layer.cornerRadius = 4
        
        self.secondbtn.layer.borderWidth = 1.0
        self.secondbtn.layer.cornerRadius = 4
        self.thirdbtn.layer.borderWidth = 1.0
        self.thirdbtn.layer.cornerRadius = 4
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if(GlobalVarible.PeachWalletVar == 1){
            GlobalVarible.PeachWalletVar = 0
            GlobalVarible.addmoneyvalue = 1
            self.dismiss(animated: true, completion: nil)
         //   ApiManager.sharedInstance.protocolmain_Catagory = self
          //  ApiManager.sharedInstance.AddMoneyMethod(UserId: Userid!, Amount: enteramountvalue,CardId: GlobalVarible.CardId)
            
        }else{
            
            
        }
        
      /* if GlobalVarible.Walletcheck == 1{
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.viewcarddetails(UserId: Userid!)
            
        GlobalVarible.Walletcheck = 0
            
        }else if GlobalVarible.PeachWalletVar == 0{
            
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.AddMoneyMethod(UserId: Userid!, Amount: enteramountvalue, CardId: GlobalVarible.CardId)

            
            
            /*let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
            cardIOVC?.modalPresentationStyle = .formSheet
            cardIOVC?.collectCardholderName = true
            
            present(cardIOVC!, animated: true, completion: nil)
            
             GlobalVarible.Walletcheck = 0*/
        }else{
        
        GlobalVarible.PeachWalletVar == 0
            
        }*/
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func firstbtn_click(_ sender: Any) {
        
        firstbtn.backgroundColor = UIColor(red:147.0/255.0, green:165.0/255.0, blue:165.0/255.0, alpha:1.0)
        
      secondbtn.backgroundColor = UIColor.clear
        thirdbtn.backgroundColor = UIColor.clear
        
       
        enteramounttext.text = "100"
    }
    
    @IBAction func secondbtn_click(_ sender: Any) {
        
        
        secondbtn.backgroundColor = UIColor(red:147.0/255.0, green:165.0/255.0, blue:165.0/255.0, alpha:1.0)
        firstbtn.backgroundColor = UIColor.clear
        thirdbtn.backgroundColor = UIColor.clear
     
        

        
         enteramounttext.text = "200"
    }
    
    @IBAction func thirdbtn_click(_ sender: Any) {
        
        
        thirdbtn.backgroundColor = UIColor(red:147.0/255.0, green:165.0/255.0, blue:165.0/255.0, alpha:1.0)
        
        secondbtn.backgroundColor = UIColor.clear
        firstbtn.backgroundColor = UIColor.clear
        

                 enteramounttext.text = "300"
        
        
    }
    
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("caneceld")
        paymentViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            
            //create Stripe card
            let card: STPCardParams = STPCardParams()
            card.number = info.cardNumber
            card.expMonth = info.expiryMonth
            card.expYear = info.expiryYear
            card.name = info.cardholderName
            card.cvc = info.cvv
            
            
            newGeneratedCardName = info.cardholderName
            newGeneratedCardNumber = info.cardNumber
            newGeneratedCardExpiryMonth = String(info.expiryMonth)
            newGeneratedCardExpiryYear = String(info.expiryYear)
            newGeneratedCardCv = info.cvv
            
            
            //Send to Stripe
            getStripeToken(card: card , resultCode: 0)
            
            
        }
        
        paymentViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    func getStripeToken(card:STPCardParams ,  resultCode: Int ) {
        
        if resultCode == 1
        {
            
            
            // get stripe token for current card
            STPAPIClient.shared().createToken(withCard: card) { token, error in
                if let token = token {
                    print(token)
                    // SVProgressHUD.showSuccessWithStatus("Stripe token successfully received: \(token)")
                    //  self.placeOrder(token)
                } else {
                    print(error!)
                    // SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
                }
            }
            
            
            
        }
            
        else
        {
            // get stripe token for current card
            STPAPIClient.shared().createToken(withCard: card) { token, error in
                if let token = token {
                    print(token)
                    // SVProgressHUD.showSuccessWithStatus("Stripe token successfully received: \(token)")
                    self.saveCard(token: token)
                } else {
                    print(error!)
                    //  SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
                }
            }
        }
        
        // KVNProgress.dismiss()
        
    }
    
    
    
    // charge money from backend
    func saveCard(token: STPToken) {
        
        print(token)
        print(newGeneratedCardName)
        
        let fullExpiry =  self.newGeneratedCardExpiryMonth + "/"  +  self.newGeneratedCardExpiryYear
        print(fullExpiry)
        let email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyemail)
        
        let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.SaveCardDetails(UserId: Userid!, UserEmail: email!, StripeToken: String(describing: token))
        
        
            
        
    }
    
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return SIZE
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = carddetailstableview.dequeueReusableCell(withIdentifier: "walletcell", for: indexPath)
        
        
         let cardNumber : UILabel = (cell.contentView.viewWithTag(1) as? UILabel)!
         let expiryDate : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        
        cardNumber.text = "XXXXXXXXXXXX" + carddata.details![indexPath.row].cardNumber!
        expiryDate.text = carddata.details![indexPath.row].cardType
        
        
        return cell
        
    }
    
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        GlobalVarible.CardId = carddata.details![indexPath.row].cardId!
        
              
        enteramountvalue = enteramounttext.text!
        
        if enteramountvalue == "" {
        
            self.showalert(message: NSLocalizedString("Please enter Amount First", comment : ""))
        
        }else{
        
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.AddMoneyMethod(UserId: Userid!, Amount: enteramountvalue, CardId: GlobalVarible.CardId)
        
        }
        
        
    }
    

    @IBAction func AddMoney_btn(_ sender: Any) {
        
        if((self.enteramounttext.text?.characters.count)! < 1){
            
            self.showalert(message: "Please enter amount first")
            
        }else{
            
            enteramountvalue = enteramounttext.text!
            
            let url1 = "http://www.tyradmin.co.za/api/wallet_checkout_id.php?amount=\(enteramounttext.text!)&currency=ZAR&paymentType=DB&user_id=\(Userid!)&shopperResultUrl=\(Config.schemeURL)://payment&notificationUrl=\(Request.notifyDomain)";
            Request.requestCheckoutID(url: url1, completion: {(checkoutID) in
                DispatchQueue.main.async {
                    guard let checkoutID = checkoutID else {
                        self.showalert(message: "Checkout ID is empty")
                        return
                    }
                    self.checkoutProvider = self.configureCheckoutProvider(checkoutID: checkoutID)
                    self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
                        DispatchQueue.main.async {
                            self.handleTransactionSubmission(transaction: transaction, error: error)
                        }
                    }, paymentBrandSelectedHandler: nil,
                       cancelHandler:({

                       }))
                }
            })
            
            
        }
    }
    func handleTransactionSubmission(transaction: OPPTransaction?, error: Error?) {
        guard let transaction = transaction else {
            self.showalert(message: (error?.localizedDescription)!)
            return
        }
        
        self.transaction = transaction
        if transaction.type == .synchronous {
            // If a transaction is synchronous, just request the payment status
            self.requestPaymentStatus()
        } else if transaction.type == .asynchronous {
            // If a transaction is asynchronous, SDK opens transaction.redirectUrl in a browser
            // Subscribe to notifications to request the payment status when a shopper comes back to the app
            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: Config.asyncPaymentCompletedNotificationKey), object: nil)
        } else {
            self.showalert(message: "Invalid transaction")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func configureCheckoutProvider(checkoutID: String) -> OPPCheckoutProvider? {
        let provider = OPPPaymentProvider.init(mode: .live)
        let checkoutSettings = Utils.configureCheckoutSettings()
        return OPPCheckoutProvider.init(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
    }
    
    func requestPaymentStatus() {
        guard let resourcePath = self.transaction?.resourcePath else {
            self.showalert(message: "Resource path is invalid")
            return
        }
        self.transaction = nil
        Request.requestPaymentStatus(resourcePath: resourcePath) { (success) in
            DispatchQueue.main.async {
                if success {
                    GlobalVarible.addmoneyvalue = 1
                    self.showalert(message: "Your payment was successful")
                } else {
                    self.showalert(message: "Your payment was unsuccessful")
                }
            }
        }
    }
    
    // MARK: - Async payment callback
    
    func didReceiveAsynchronousPaymentCallback() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Config.asyncPaymentCompletedNotificationKey), object: nil)
        self.checkoutProvider?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
                self.requestPaymentStatus()
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
        
        
        if(GlobalVarible.Api == "viewcard"){
            
            
            carddata = data as! CardDetailsModel
            
            
            if(carddata.result == 0){
                
                toastLabel.isHidden = false
                SIZE = 0
                self.carddetailstableview.isHidden = true
                
                
            }else{
                
                toastLabel.isHidden = true
                
                SIZE = (carddata.details?.count)!
                self.carddetailstableview.isHidden = false
                carddetailstableview.reloadData()
            }
            
            
        }
        
        if(GlobalVarible.Api == "Savecard"){
            
            savedata = data as! SaveCardModel
            
            if(savedata.result == 0){
                
                self.showalert(message: savedata.msg!)
            }else{
                
                //self.showalert1(message: "Card Details Saved Succesfully")
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.viewcarddetails(UserId: Userid!)
            }
            
            
            
            
        }
        
          if(GlobalVarible.Api == "addmoneymodel"){
            
            addmoneydata = data as! AddMoneyModel
            
            if addmoneydata.result == 1{
                GlobalVarible.addmoneyvalue = 1
            self.dismiss(animated: true, completion: nil)
                
            }else{
                
             self.showalert(message: addmoneydata.msg!)
            }
            
            
            
        }

    }
 
}
