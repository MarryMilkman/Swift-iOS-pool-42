//
//  Model.swift
//  Swift_Rush00
//
//  Created by Ivan SELETSKYI on 10/7/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import Foundation

let MY_AWESOME_UID = "1dced77c0b65ffe45f68c7a884d12afecb8ff6344016f0b4a4ddc72ec9c8e1b6"
let MY_AWESOME_SECRET = "64cf3af54089ae1578ae3b62bf4dff601ab19d62d742064563387506b64c904f"
let REDIRECT_URL = "https://api.intra.42.fr/oauth/authorize?client_id=1dced77c0b65ffe45f68c7a884d12afecb8ff6344016f0b4a4ddc72ec9c8e1b6&redirect_uri=app%3A%2F%2FPOSTANDGETAPP_ISELETSK&response_type=code"

var tokenObj: AnyObject? = nil

var userInfo: [Any]? = nil

var requestStatus: Int = 0
