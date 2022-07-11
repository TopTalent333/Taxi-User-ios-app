//
//  SelectPackageViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 28/06/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class SelectPackageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
     var  rentaldata : RentalModel!
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var innerview: UIView!
    
      var  tablesize = 0
    
    @IBOutlet weak var selectpackagetable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerview.layer.cornerRadius = 5
        innerview.clipsToBounds = true
        
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false


        tablesize = (rentaldata.details?.count)!
        
      //  let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onTap))
        
        
      //  mainview.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewclickbackbtn(_ sender: Any) {
         self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    
   /* func onTap(_ gestureRecognizer: UITapGestureRecognizer) {
       
    self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return tablesize
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = selectpackagetable.dequeueReusableCell(withIdentifier: "selectpackagecell", for: indexPath)
        
        
        
      
        let label : UILabel = (cell.contentView.viewWithTag(1) as? UILabel)!
       
        
               label.text = rentaldata.details![indexPath.row].rentalCategory
        
                
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectpackagetable.deselectRow(at: indexPath as IndexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let choosecategoryviewcontroller = storyBoard.instantiateViewController(withIdentifier: "ChooseCategoryViewController") as! ChooseCategoryViewController
        // bookrentalviewcontroller.viewcontrollerself = self
        choosecategoryviewcontroller.rentaldata = self.rentaldata
        choosecategoryviewcontroller.toplabeldata = rentaldata.details![indexPath.row].rentalCategory!
        choosecategoryviewcontroller.index = indexPath.row
        choosecategoryviewcontroller.modalPresentationStyle = .overCurrentContext
        
        self.present(choosecategoryviewcontroller, animated:true, completion:nil)
        
                  
        
        
        
    }
    

  
}
