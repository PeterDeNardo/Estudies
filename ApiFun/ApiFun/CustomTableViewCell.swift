//
//  CustomTableViewCell.swift
//  ApiFun
//
//  Created by Peter De Nardo on 16/01/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    var postId : String!
    var navigationControlle : UINavigationController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editPost(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editPostModal") as! CreatePostViewController
        
        vc.TxtPostTitle?.text = postTitle.text!
        vc.TxtPostContent?.text = postContent.text!
        vc.UIImageView?.image = #imageLiteral(resourceName: "02_Cuppy_lol.png")
        vc._id = postId
        vc.editState = true
        
        navigationControlle.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func delePost(_ sender: Any) {
        guard let baseURL = URL(string: "http://LOCALHOST:8080/feed/post/" + self.postId) else {
            return
        }
        guard let userToken = UserDefaults.standard.value(forKey: "userToken") else {
            return print("token ???")
        }
        var request = URLRequest(url: baseURL);
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("bearer \(userToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE";
        
        _ = URLSession.shared.dataTask(with: request) { data, response, error in
            if data != nil {
                
            } else {
                print(error)
            }
        }.resume()
    }
}


extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}
