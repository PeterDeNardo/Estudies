//
//  NewPostViewController.swift
//  ApiFun
//
//  Created by Peter De Nardo on 18/01/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit
import Alamofire

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var UIImageView: UIImageView!
    @IBOutlet weak var TxtPostContent: UITextField!
    @IBOutlet weak var TxtPostTitle: UITextField!
    var _id : String = "0"
    var editState : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ExitModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SetUIImageView(_ sender: UIButton) {
        let imagePiicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePiicker.delegate = self
            imagePiicker.sourceType = .photoLibrary
            imagePiicker.allowsEditing = false
            
            self.present(imagePiicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func CretePost(_ sender: Any) {
        let jsonData = [
            "title" : TxtPostTitle.text!,
            "content" : TxtPostContent.text!,
        ]
        
        do{
            let json = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            postConnect(jsonData: json)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func postConnect (jsonData : Data) {
        var baseURL = URL(string: "http://localhost:8080/feed/post")!
        var method : HTTPMethod = .post
        if editState {
            if _id != nil {
                baseURL = URL(string: "http://localhost:8080/feed/post/\(_id)")!
                method = .put
                print(baseURL)
            }
        }
        guard let userToken = UserDefaults.standard.value(forKey: "userToken") else {
            return print("tolken ???")
        }
       
        let headers : HTTPHeaders = [
            "Authorization" : "Bearer \(userToken)"
        ]
        
        Alamofire.upload(multipartFormData: { multipart in
            multipart.append(self.TxtPostTitle.text!.data(using: .utf8)!, withName: "title")
            multipart.append(self.TxtPostContent.text!.data(using: .utf8)!, withName: "content")
            multipart.append((self.UIImageView.image?.jpegData(compressionQuality: 0.2))!,
                             withName: "image",
                             fileName: "image.jpg",
                             mimeType: "image/jpg")
        }, to: baseURL, method: method, headers: headers, encodingCompletion: { (result) in
            
            })
    }
}

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            UIImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}


