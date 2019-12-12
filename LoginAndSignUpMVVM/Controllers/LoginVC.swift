//
//  LoginVC.swift
//  LoginAndSignUpMVVM
//
//  Created by volive solutions on 12/12/19.
//  Copyright © 2019 RamiReddy. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var mobileNumTF: UITextField!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.delgate = self
        
        loginViewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunction))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK:- TAP GESTURE METHOD
    @objc func tapGestureFunction(){
        self.view.window?.endEditing(true)
    }
    
    //MARK:- LOGIN BTN ACTION
    @IBAction func loginBtnAction(_ sender: Any) {
        
        loginViewModel.sendValue(inputData: LoginCredentials(mobileNum: mobileNumTF.text ?? "", password: "123456"))
        
    }
    
    //MARK: TextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}


extension LoginVC:ViewControllerDelegate{
    
    func successResponse(response: Any) {
        
        
        print("successs response",response)
        let alertController = UIAlertController(title: "successfully registered", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: {
            
        })
    }
    
    func FailureRespons(response: Any) {
        let alertController = UIAlertController(title: "successfully registered", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: {
            
        })
    }
    
    func sendMessageForViewController(message: String?) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: {
            
        })
    }
    
    
}
extension LoginVC: SingleButtonDialogPresenter { }
