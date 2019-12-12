//
//  ViewController.swift
//  LoginAndSignUpMVVM
//
//  Created by volive solutions on 12/12/19.
//  Copyright © 2019 RamiReddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,APIServiceCallBackDelegates {

    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunction))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    //MARK:- TAP GESTURE METHOD
    @objc func tapGestureFunction(){
        self.view.window?.endEditing(true)
    }
    
    
    //MARK:- SUBMIT BTN ACTION
    @IBAction func submitBtnAction(_ sender: Any) {
        
    }
    
    
    //MARK: TextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: NetworkDelegate methods
    func successResponse(response: Any) {
        let responseDict = response as! [String: Any]
        if (responseDict["status"] as! Int) == 1{
            let alertController = UIAlertController(title: "successfully registered", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    func failureResponse(response: Any) {
        let alertController = UIAlertController(title: "error", message: (response as! [String: Any])["ErrorMessage"] as? String, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

