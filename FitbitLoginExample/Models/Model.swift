//
//  Model.swift
//  FitbitLoginExample
//
//  Created by Marcy Vernon on 8/14/20.
//

import SwiftUI

class Model: AuthHandlerType {

    var session: NSObject? = nil
    var contextProvider: AuthContextProvider?

    func auth(_ completion: @escaping ((String?, Error?) -> Void)) {
        guard let authUrl = Constants.authUrl else {
            completion(nil, nil)

            return
        }

        var urlComponents = URLComponents(url: authUrl, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "response_type", value: Constants.responseType),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_url", value: Constants.redirectUrl),
            URLQueryItem(name: "scope", value: Constants.scope.joined(separator: " ")),
            URLQueryItem(name: "expires_in", value: String(Constants.expires))
        ]

        guard let url = urlComponents?.url else {
            completion(nil, nil)

            return
        }

        auth(url: url, callbackScheme: Constants.redirectScheme) {
            url, error in
            if error != nil {
                completion(nil, error)
            } else if let `url` = url {
                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                      let item = components.queryItems?.first(where: { $0.name == "code" }),
                      let code = item.value else {
                    completion(nil, nil)

                    return
                }

                completion(code, nil)
            }
        }
    }

}

