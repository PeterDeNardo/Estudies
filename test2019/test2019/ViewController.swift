//
//  ViewController.swift
//  test2019
//
//  Created by Peter De Nardo on 05/02/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var artImage: UIImageView!
    
    let clientId : String = "bb8512a5b465f20bfee4"
    let clientSecret : String = "52e68e43eeae79bb9de7ea456a938c42"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    struct UserLogged : Decodable {
        var token: String
    }
    
    struct art : Decodable {
        var id: String
    }

    @IBAction func getImage(_ sender: Any) {
        getUserTolken()
        getArtirst()
    }
    
    func getUserTolken () {
        guard let baseUrl = URL(string: "https://api.artsy.net/api/tokens/xapp_token?client_id=\(clientId)&client_secret=\(clientSecret)") else {
            return
        }
        var request = URLRequest(url: baseUrl);
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST";
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    if let user : UserLogged = try JSONDecoder().decode(UserLogged.self, from: data) {
                        UserDefaults.standard.set(user.token, forKey: "userToken")
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    func getArtirst () {
        guard let baseUrl = URL(string: "https://api.artsy.net/api/artworks?total_count=1") else {
            return
        }
//        guard let baseUrl = URL(string: "https://d32dm0rphc51dk.cloudfront.net/dTGcd0Xx0aEp_MDFdHIUIw/large.jpg") else {
//            return
//        }
        guard let userToken = UserDefaults.standard.value(forKey: "userToken") else {
            return print("tolken ???")
        }
        let method : HTTPMethod = .get
        let headers : HTTPHeaders = [
            "X-Xapp-Token" : "\(userToken)"
        ]
        Alamofire.request(baseUrl, method: method, headers: headers).responseJSON(completionHandler: { response in
            if response.data != nil {
                do {

                    print(response.data)
//                    let json = try JSONDecoder().decode(art.self, from: response.data!)
//                    print(json)

                    let json = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    print(json)

                } catch {
                    print(error)
                }
            }
        });
        
//        Alamofire.request(baseUrl, method: .get).responseImage(completionHandler: { response in
//            guard let image = response.result.value else {
//                print(response.result.value)
//                return
//            }
//            self.artImage.image = image
//            print(23)
//        });
    }
    
}

