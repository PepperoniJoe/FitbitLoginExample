//
//  Constants.swift
//  FitbitLogIn
//
//  Created by Marcy Vernon on 8/14/20.
//
import UIKit

struct Constants {

    static let authUrl = URL(string: "https://www.fitbit.com/oauth2/authorize")
    static let responseType = "code"
    static let redirectScheme = "FitbitLoginExample://"
    static let redirectUrl = "\(redirectScheme)fitbit/auth"
    static let scope = ["activity", "heartrate", "location", "nutrition", "profile", "settings", "sleep", "social", "weight"]
    static let expires = "604800"

    private init() {}

}
