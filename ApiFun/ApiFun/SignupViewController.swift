//
//  SignupViewController.swift
//  ApiFun
//
//  Created by Peter De Nardo on 22/01/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupUser(_ sender: Any) {
        
        let jsonData = [
            "email" : txtUserEmail.text!,
            "name" : txtUserName.text!,
            "password" : txtUserPassword.text!
            
        ]
        
        do{
            let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            signupConnect(jsonData: json)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signupConnect(jsonData : Data) {
        guard let baseUrl = URL(string: "http://LOCALHOST:8080/auth/signup") else {
        //guard let baseUrl = URL(string: "http://192.168.100.7:8080/auth/signup") else {
            return
        }
        var request = URLRequest(url: baseUrl);
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT";
        request.httpBody = jsonData;
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    print(response)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    @IBAction func cancelSignup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
