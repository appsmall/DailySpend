//
//  ProfileVC.swift
//  DailySpend
//
//  Created by apple on 04/01/19.
//  Copyright © 2019 outect. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(updateUIAfterDelay), with: nil, afterDelay: 0.0)
    }
    
    @objc func updateUIAfterDelay() {
        userImageView.cornerView()
        saveButton.cornerView()
    }
    
    func alertWithSingleAction(message : String){
        let okAction = UIAlertAction(title: Alert.ok, style: .default, handler: nil)
        let actions = [okAction]
        Utility.alert(on: self, title: Alert.alert, message: message, withActions: actions, style: .alert)
    }
    
    
    // MARK:- IBACTIONS
    @IBAction func backButtonPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraBtnPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alertController = UIAlertController(title: uploadPicture, message: pleaseSelectPictureMethod, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: openCamera, style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                // Camera available
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
                
            } else {
                // Camera not available
                self.alertWithSingleAction(message: cameraNotAvailable)
            }
        }
        let photoLibraryAction = UIAlertAction(title: openPhotoGallery, style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                // Photo Library available
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                // Photo Library not available
                self.alertWithSingleAction(message: photoLibraryNotAvailable)
            }
        }
        let cancelAction = UIAlertAction(title: Alert.cancel, style: .destructive, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    }
}


// MARK:- UIIMAGE PICKER CONTROLLER DELEGATE METHODS
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage = UIImage()
        
        if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        }
        
        self.userImageView.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
