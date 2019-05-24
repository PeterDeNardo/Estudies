//
//  LoginViewController.swift
//  ApiFun
//
//  Created by Peter De Nardo on 16/01/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit

struct UserLogged : Decodable {
    var token: String
    var userId: String
}

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func loginRequest(_ sender: Any) {
        
        let jsonData = [
            "email" : txtUserName.text!,
            "password" : txtUserPassword.text!
        ]
        
        do{
            let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            loginConnect(jsonData: json)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func loginConnect (jsonData: Data) {
        guard let baseUrl = URL(string: "http://LOCALHOST:8080/auth/login") else {
        //guard let baseUrl = URL(string: "192.168.100.7:8080/auth/login") else {
            return
        }
        var request = URLRequest(url: baseUrl);
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST";
        request.httpBody = jsonData;
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    if let user : UserLogged = try JSONDecoder().decode(UserLogged.self, from: data) {
                        print(user.token)
                        UserDefaults.standard.set(user.token, forKey: "userToken")
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }
}
    



