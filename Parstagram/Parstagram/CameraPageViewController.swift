//
//  CameraPageViewController.swift
//  Parstagram
//
//  Created by Naoki on 11/15/19.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

//UIImagePickerControllerDelegate is to enable camera
//UINavigationControllerDelegate is required too ^
class CameraPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var cameraImg: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func keyboardDis(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func postBtn(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        print("post pressed!")
        post["caption"] = commentText.text!
        post["user"] = PFUser.current()!
        
        let imageData = cameraImg.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground{(sucess, error) in
            if sucess {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cameraBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
     
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func photoLibraryButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
        

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scale_image = image.af_imageAspectScaled(toFill: size)
        
        cameraImg.image = scale_image
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissKeybard(_ sender: Any) {
        view.endEditing(true)
    }
}
