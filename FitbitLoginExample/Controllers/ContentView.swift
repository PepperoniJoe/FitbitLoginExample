//
//  ContentView.swift
//  FitbitLoginExample
//
//  Created by Marcy Vernon on 8/14/20.
//

import SwiftUI

var model = Model()

struct ContentView: View {
    @State private var showingAlert = false
    @State private var title        = ""
    @State private var message      = ""
    
    var body: some View {
        Button (action: {
            requestAuth()
        }) {
            Text("Start Fitbit Auth").padding()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func requestAuth() {
        if let context = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            model.contextProvider = AuthContextProvider(context)
        }
        
        model.auth { authCode, error in
            if error == nil {
                print("Your authorization code is \(authCode ?? "missing")")
                title        = "Success!"
                message      = "The authorization code is " + (authCode ?? "Missing Authorization")
                showingAlert = true
            } else {
                print(error?.localizedDescription ?? "The operation couldn't be completed.")
                title        = "Oops!"
                message      = "The authorization process failed. Contact the developer."
                showingAlert = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
