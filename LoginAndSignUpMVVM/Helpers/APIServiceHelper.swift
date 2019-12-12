//
//  APIServiceHelper.swift
//  LoginAndSignUpMVVM
//
//  Created by volive solutions on 12/12/19.
//  Copyright © 2019 RamiReddy. All rights reserved.
//

import Foundation

public protocol APIServiceCallBackDelegates{
    /// Called when request is sent to server successfully
    ///
    /// - Parameters:
    ///   - response: Success response which is coming from server
    ///   - requestType: Type of request
    func successResponse(response:Any)
    
    /// Called when request is failed
    ///
    /// - Parameters:
    ///   - response: Failure response which is coming from server
    ///   - requestType: Type of request
    func failureResponse(response:Any)
}



public class APIServiceHelper:NSObject{
    
    
    
    
     public static let sharedInstance: APIServiceHelper = APIServiceHelper()
     public var delegate: APIServiceCallBackDelegates?
    
    //MARK: internal functions or post method and get method
    
    internal func postRequestToServer(urlString: String, input: [String: Any]){
        
        do{
            if JSONSerialization.isValidJSONObject(input){
                let requestURL = URL(string: urlString)
                var request = URLRequest(url: requestURL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
                
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let inputData = try JSONSerialization.data(withJSONObject: input, options: .prettyPrinted)
                request.httpBody = inputData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    if data != nil{
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            print("json data:\(json)")
                            DispatchQueue.main.async(execute: {
                               self.delegate?.successResponse(response:json)
//                                self.appDelegate.activityIndicatorStop()
                            })
                        }
                        catch {
                        }
                    }
                    else{
                        DispatchQueue.main.async(execute: {
//                            let errorMessage = [Constants.ERROR_MESSAGE :"Some thing went wrong, Please try agaain"]
//                            self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
//                            self.appDelegate.activityIndicatorStop()
                        })
                        print("no response")
                    }
                })
                task.resume()
            }else{
//                let errorMessage = [Constants.ERROR_MESSAGE:"Invalid input"]
//                self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
//                self.appDelegate.activityIndicatorStop()
            }
        }
         catch let error{
//            print("catch error is ",error.localizedDescription)
//            let errorMessage = [Constants.ERROR_MESSAGE: error.localizedDescription]
//            self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
//            self.appDelegate.activityIndicatorStop()
        }
    }
    
    internal func getRequestToServer(urlString: String, input:[String: Any]){
        do{
            if JSONSerialization.isValidJSONObject(input){
                let requestURL = URL(string: urlString)
                var request = URLRequest(url: requestURL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
                
                request.httpMethod = "GET"
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    if data != nil{
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            print("json data:\(json)")
                            DispatchQueue.main.async(execute: {
                                self.delegate?.successResponse(response:json)
//                                self.appDelegate.activityIndicatorStop()
                            })
                        }
                        catch {
                        }
                    }
                    else{
                        DispatchQueue.main.async(execute: {
//                            let errorMessage = [Constants.ERROR_MESSAGE :"Some thing went wrong, Please try agaain"]
//                            self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
//                            self.appDelegate.activityIndicatorStop()
                        })
                        print("no response")
                    }
                })
                task.resume()
            }else{
//                let errorMessage = [Constants.ERROR_MESSAGE:"Invalid input"]
//                self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
//                self.appDelegate.activityIndicatorStop()
            }
        }
        //        catch let error{
        //            print("catch error is ",error.localizedDescription)
        //            let errorMessage = [Constants.ERROR_MESSAGE: error.localizedDescription]
        //            self.delegate?.failureResponse(response:errorMessage, ForRequestType: type)
        //            self.appDelegate.activityIndicatorStop()
        //        }
    }
    
}
