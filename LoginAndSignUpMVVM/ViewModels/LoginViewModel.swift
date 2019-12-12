//
//  LoginViewModel.swift
//  LoginAndSignUpMVVM
//
//  Created by volive solutions on 12/12/19.
//  Copyright © 2019 RamiReddy. All rights reserved.
//

import Foundation
import UIKit



protocol LoginViewModelProtocol {
    func sendValue(inputData:LoginCredentials)
}

protocol ViewControllerDelegate {
    func successResponse(response:Any)
    func FailureRespons( response:Any)
   
    
}

class LoginViewModel:LoginViewModelProtocol,APIServiceCallBackDelegates {
    
    
    var navigateBack: (() -> ())?
    var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
    
      var delgate: ViewControllerDelegate?
    
    func successResponse(response: Any) {
        let responseDict = response as! [String: Any]
        if (responseDict["status"] as! Int) == 1{
            
            delgate?.successResponse(response: response)

        }
    }
    
    func failureResponse(response: Any) {
        delgate?.FailureRespons(response: response)
    }
    
 
    func sendValue(inputData: LoginCredentials) {
         print("email and password",inputData.mobileNum,inputData.password)
        
 
        if inputData.mobileNum == ""{
            
            
            let okAlert = SingleButtonAlert(
                title: "Mobile number is empty",
                message: "Could not add your mobile num",
                action: AlertAction(buttonTitle: "OK", handler: { print("Ok pressed!") })
            )
            self.onShowError?(okAlert)
            
        }else{
           
            var jsonObject = [String: Any]()
            jsonObject["API-KEY"] = APIConstants.APIKEY
            jsonObject["mobile"] = inputData.mobileNum
            jsonObject["country_code"] = "IN"
            jsonObject["phone_code"] = "+91"
            
            APIServiceHelper.sharedInstance.delegate = self
            APIServiceHelper.sharedInstance.postRequestToServer(urlString: APIConstants.VERIFY_MOBILENUM_URL, input: jsonObject)
        }
        
    }
 
    //MARK:- VALIDATOR FOR EMAIL
    fileprivate func validateUserNameAsEmailFormat(_ userName: String) -> Bool
    {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: userName)
    }

    
}
