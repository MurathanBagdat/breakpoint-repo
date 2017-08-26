//
//  meVC.swift
//  BreakPoint
//
//  Created by Melisa Kısacık on 24.08.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit
import Photos
import Firebase

class meVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userEmailLabel.text = Auth.auth().currentUser?.email
    }
    
    
    //Actions###
    @IBAction func signoutButtonPrsd(_ sender: UIButton) {
        try? Auth.auth().signOut()
        performSegue(withIdentifier:SIGNOUT, sender: nil)
    }
    
    @IBAction func chooseAnImageButtonPrsd(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: "Choose an image for your profile..", message: "", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
        let imagePath = Auth.auth().currentUser!.uid + "/\(Int(Date.timeIntervalSinceReferenceDate * 10)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        StorageService.instance.REF_BASE.child(imagePath).putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error uploading: \(error)")
                return
            }
            self.profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)

    }


    
    
}
