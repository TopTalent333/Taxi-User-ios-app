//
//  ChooseCategoryViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 28/06/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class ChooseCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mainview: UIView!
    
    
    
     var  rentaldata : RentalModel!
    
    var tablesize = 0
    
    
    var toplabeldata = ""
    
    let imageUrl = API_URL.imagedomain

    
    var index = 0
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var toplabeltext: UILabel!
    
    @IBOutlet weak var choosecategorytabel: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerview.layer.cornerRadius = 5
        innerview.clipsToBounds = true
        
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false


        toplabeltext.text = toplabeldata
        
        tablesize = (rentaldata.details![index].rentalPakageCar?.count)!
        
      //  let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onTap))
        
        
      //  mainview.addGestureRecognizer(gesture)
        
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewclickbackbtn(_ sender: Any) {
         self.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
        
    }
    
    
    
       
    
    @IBAction func topdropdownbtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return tablesize
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = choosecategorytabel.dequeueReusableCell(withIdentifier: "choosepackagecell", for: indexPath)
        
        
        let imageview :UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        let carnamelabel : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        let cardetailelabel : UILabel = (cell.contentView.viewWithTag(3) as? UILabel)!
        
        let pricelabel : UILabel = (cell.contentView.viewWithTag(4) as? UILabel)!
        
        
        let newString = rentaldata.details![index].rentalPakageCar![indexPath.row].carTypeImage!
        
        print(newString)
        
        let url = imageUrl + newString
        
        let url1 = NSURL(string: url)
        
        imageview.af_setImage(withURL:
            url1! as URL,
                                   placeholderImage: UIImage(named: "dress"),
                                   filter: nil,
                                   imageTransition: .crossDissolve(1.0))
        
        
        carnamelabel.text = rentaldata.details![index].rentalPakageCar![indexPath.row].carTypeName
        
        pricelabel.text = GlobalVarible.currencysymbol + " " + rentaldata.details![index].rentalPakageCar![indexPath.row].price!
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        choosecategorytabel.deselectRow(at: indexPath as IndexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let confirmbookingrentalviewcontroller = storyBoard.instantiateViewController(withIdentifier: "ConfirmBookingRentalViewController") as! ConfirmBookingRentalViewController
        confirmbookingrentalviewcontroller.firstindex = self.index
        confirmbookingrentalviewcontroller.secondindex = indexPath.row
        confirmbookingrentalviewcontroller.rentaldata = self.rentaldata
        
              
        self.present(confirmbookingrentalviewcontroller, animated:true, completion:nil)

        
    }


    
}
