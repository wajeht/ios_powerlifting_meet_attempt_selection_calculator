//
//  ViewController.swift
//  Powerlifting Attempt Selectoin Calculator
//
//  Created by Ko Nyein on 3/25/20.
//  Copyright © 2020 Kyaw Nyein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblMale: UIButton!
    @IBOutlet weak var lblFemale: UIButton!
    @IBOutlet weak var lblCalculate: UIButton!
    
    @IBOutlet weak var txt_bodyWeight: UITextField!
    
    @IBOutlet weak var txt_sqRep: UITextField!
    @IBOutlet weak var txt_sqWeight: UITextField!
    @IBOutlet weak var txt_sqRpe: UITextField!
    
    @IBOutlet weak var txt_bnRep: UITextField!
    @IBOutlet weak var txt_bnWeight: UITextField!
    @IBOutlet weak var txt_bnRpe: UITextField!
    
    @IBOutlet weak var txt_dlRep: UITextField!
    @IBOutlet weak var txt_dlWeight: UITextField!
    @IBOutlet weak var txt_dlRpe: UITextField!
    
    var sqRep = 0
    var sqWeight = 0
    var sqRpe = 0
    var sqMax = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblCalculate.layer.cornerRadius = 10
        self.hideKeyboardWhenTappedAround()
        
        // shift keyboard upword on textviw starts
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    // shift keyboard upword on textviw ends
    
    @IBAction func aboutAlert(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "This app is free forever, but it still cost effort to maintain it on AppStore. Want to buy a cup of coffee?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func btnMale(_ sender: Any) {
        
        if lblFemale.isSelected {
            lblFemale.isSelected = false
            lblMale.isSelected = true
        } else {
            lblMale.isSelected = true
        }
    }

    @IBAction func btnFemale(_ sender: Any) {
        if lblMale.isSelected {
            lblMale.isSelected = false
            lblFemale.isSelected = true
        } else {
            lblFemale.isSelected = true
        }
    }
    
    @IBAction func btnCalculate(_ sender: Any) {
        
        if txt_bodyWeight.text == "" ||
            txt_bodyWeight.text == "" ||
            txt_sqRep.text == "" ||
            txt_sqWeight.text == "" ||
            txt_sqRpe.text == "" ||
            txt_bnRep.text == "" ||
            txt_bnWeight.text == "" ||
            txt_bnRpe.text == "" ||
            txt_dlRep.text == "" ||
            txt_dlWeight.text == "" ||
            txt_dlRpe.text == "" {
            
            let alert = UIAlertController(title: "", message: "Please provide all input fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        sqRep = Int(txt_sqRep.text ?? "") ?? 0
        sqWeight = Int(txt_sqWeight.text ?? "") ?? 0
        sqRpe = Int(txt_sqRpe.text ?? "") ?? 0
        sqMax = Int(oneRepMax(rep: sqRpe, weight: sqWeight, rpe: sqRpe))
        
        if segue.identifier == "segue"{
            let rvc = segue.destination as! ResultViewController
            rvc.sqOneRepMax = "SQUAT e1RM: " + String(sqMax)
        }
    }
    
    
    func oneRepMax(rep: Int, weight: Int, rpe: Int) -> Double {
        let inside = ((10 - (rpe + 1)) + rep)
        let inside1 = (Int) (Double(inside * weight) * 0.03)
        let final = inside1 + weight

        return Double(final)
    }
}


// hide keyboard on tap anywhere
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

