//
//  SelectCardViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 24/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import Stripe

class SelectCardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CardIOPaymentViewControllerDelegate,MainCategoryProtocol {
    /// This method will be called if the user cancels the scan. You MUST dismiss paymentViewController.
    /// @param paymentViewController The active CardIOPaymentViewController.
    
    
    
    var savedata : SaveCardModel!
    var carddata : CardDetailsModel!
    var deletedata : DeleteCardModel!
    
    var senderTag = 0
    
    var newGeneratedCardName = ""
    var newGeneratedCardNumber = ""
    var newGeneratedCardExpiryMonth = ""
    var newGeneratedCardExpiryYear = ""
    var newGeneratedCardCv = ""
    
    
    var Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(key: NsUserDekfaultManager.Keyuserid)
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var SIZE = 0
    
    var toastLabel : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        
        
        toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-300, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(toastLabel)
        toastLabel.text =  NSLocalizedString("No Card Added!!", comment: "")
        
        toastLabel.isHidden = true
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.viewcarddetails(UserId: Userid!)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onAddCard(_ sender: Any) {
        /*
         let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
         cardIOVC?.modalPresentationStyle = .formSheet
         cardIOVC?.collectCardholderName = true
         
         present(cardIOVC!, animated: true, completion: nil)
         */
        saveCard()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return  SIZE
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCardCell") as! SelectCardCell
        
        cell.deleteButton.tag = indexPath.row
        //  cell.payButton.tag = indexPath.row
        
        cell.deleteButton.addTarget(self, action: #selector(onDeleteCard), for: UIControlEvents.touchUpInside)
        // cell.payButton.addTarget(self, action: #selector(onPay(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        print(carddata.details![indexPath.row])
        cell.cardNumber.text = "XXXXXXXXXXXX" + carddata.details![indexPath.row].cardNumber!
        cell.expiryDate.text = carddata.details![indexPath.row].cardType
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(indexPath.row)
        
        GlobalVarible.MatchCardSelect = 1
        GlobalVarible.CardId = carddata.details![indexPath.row].cardId!
        self.dismiss(animated: true, completion: nil)
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
            print(info.cardType)
            
            
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
                    self.saveCard()
                } else {
                    print(error!)
                    //  SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
                }
            }
        }
        
        // KVNProgress.dismiss()
        
    }
    
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    
    // charge money from backend
    func saveCard() {
        let url1 = "http://www.tyradmin.co.za/api/save_card_checkout.php?user_id=\(self.Userid!)&shopperResultUrl=\(Config.schemeURL)://payment&notificationUrl=\(Request.notifyDomain)";
        Request.registerCheckoutID(url: url1, completion: {(checkoutID) in
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
        }
    }
    
    func configureCheckoutProvider(checkoutID: String) -> OPPCheckoutProvider? {
        let provider = OPPPaymentProvider.init(mode: .live)
        let checkoutSettings = Utils.configureCheckoutSettings()
        checkoutSettings.storePaymentDetails = .always
        return OPPCheckoutProvider.init(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
    }
    
    func requestPaymentStatus() {
        guard let resourcePath = self.transaction?.resourcePath else {
            self.showalert(message: "Resource path is invalid")
            return
        }
        self.transaction = nil
        Request.requestRegisterStatus(resourcePath: resourcePath) { (success) in
            DispatchQueue.main.async {
                ApiManager.sharedInstance.viewcarddetails(UserId: self.Userid!)
                self.tableView.reloadData()
                let message = success ? "Card saved successfully" : "Card save failed"
                MBProgressHUD.hide(for: self.view, animated: true)
                self.showalert(message: message)
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
    
    
    
    
    
    func onDeleteCard(sender: UIButton ) {
        
        print("delete")
        
        self.senderTag = sender.tag
        
        
        
        let alert = UIAlertController(title: "Delete Card", message: NSLocalizedString("Are you sure want to delete this card ?", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        
        self.present(alert, animated: true, completion: nil)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.DeleteCard(CardId: self.carddata.details![sender.tag].cardId!)
            
            //  ApiController.sharedInstance.parsDataSimple(deleteCardUrl + parsedData.viewCards!.response!.message![sender.tag].cardId!, reseltCode: 19)
            
        }))
        
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
    }
    
    func onPay(sender: UIButton ) {
        
        
        self.senderTag = sender.tag
        
        print("pay")
        
        // let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        //  let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! SelectCardCell
        
        
        
        
        
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
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.viewcarddetails(UserId: self.Userid!)
                
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
                self.tableView.isHidden = true
                
                
            }else{
                
                toastLabel.isHidden = true
                
                SIZE = (carddata.details?.count)!
                self.tableView.isHidden = false
                tableView.reloadData()
            }
            
            
        }
        
        if(GlobalVarible.Api == "Savecard"){
            
            savedata = data as! SaveCardModel
            
            if(savedata.result == 0){
                
                self.showalert(message: savedata.msg!)
            }else{
                
                self.showalert1(message: savedata.msg!)
                
            }
            
            
            
            
        }
        
        
        if(GlobalVarible.Api == "deletecard")
        {
            
            deletedata = data as! DeleteCardModel
            
            if(deletedata.result == 0){
                
                self.showalert(message: deletedata.msg!)
            }else{
                
                self.showalert1(message: deletedata.msg!)
                
            }
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
}

