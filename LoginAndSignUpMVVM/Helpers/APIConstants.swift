//
//  APIConstants.swift
//  LoginAndSignUpMVVM
//
//  Created by volive solutions on 12/12/19.
//  Copyright © 2019 RamiReddy. All rights reserved.
//

import Foundation
import UIKit

public class APIConstants {
    
    public static let BASE_URL = "http://volive.in/ontime/api/Customer/"
    public static let APIKEY = "1514209135"
    public static let VERIFY_MOBILENUM_URL = BASE_URL + "send_otp"
    public static let LOGIN_URL = BASE_URL + "login"
    public static let SIGN_UP_URL = BASE_URL + "user_register"
    
}
