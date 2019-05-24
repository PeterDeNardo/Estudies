//
//  NewPostViewController.swift
//  ApiFun
//
//  Created by Peter De Nardo on 18/01/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController, UIImagePickerController {

    @IBOutlet weak var UIImageView: UIImageView!
    @IBOutlet weak var TxtPostContent: UITextField!
    @IBOutlet weak var TxtPostTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func ExitModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func SetUIImageView(_ sender: UIButton) {
        var imagePiicker = UIImagePickerController()
        imagePiicker.delegate = self
        imagePiicker.sourceType = .savedPhotosAlbum
        imagePiicker.allowsEditing = false
        
        self.present(imagePiicker, animated = true, completion: nil)
        
    }
    @IBAction func CretePost(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
