//
//  ViewController.swift
//  Instagrid
//
//  Created by Aymerik Vallejo on 11/10/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    private var currentTouchedButtonTag = 0
    
    @IBOutlet weak var centralView: UIView!
    
    @IBOutlet weak var topLeft: UIButton!
    @IBOutlet weak var topRight: UIButton!
    @IBOutlet weak var botLeft: UIButton!
    @IBOutlet weak var botRight: UIButton!
    
    @IBOutlet weak var selectedButton1: UIImageView!
    @IBOutlet weak var selectedButton2: UIImageView!
    @IBOutlet weak var selectedButton3: UIImageView!
    
    @IBOutlet weak var stackViewSwipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        topLeft.isHidden = true

        self.initSwipeDirection()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.initSwipeDirection()
        }
    }
    
    
    private func initSwipeDirection() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            stackViewSwipe?.direction = .up
        } else {
            stackViewSwipe?.direction = .left
        }
    }
    
    @IBAction func LayoutButtons(_ sender: UIButton) {
        
        switch sender.tag {
            
        case 5:
            
            self.layoutConfig(topLeft: true, topRight: false, botLeft: false, botRight: false, selectedButton1: false, selectedButton2: true, selectedButton3: true)
            
            newLayout()
            
            
        case 6:
            self.layoutConfig(topLeft: false, topRight: false, botLeft: true, botRight: false, selectedButton1: true, selectedButton2: false, selectedButton3: true)
            
            newLayout()
            
            
        case 7:
            
            self.layoutConfig(topLeft: false, topRight: false, botLeft: false, botRight: false, selectedButton1: true, selectedButton2: true, selectedButton3: false)
            
            newLayout()
            
            
        default: break
            
        }
    }
    
    private func layoutConfig(topLeft: Bool, topRight: Bool, botLeft: Bool, botRight: Bool, selectedButton1: Bool, selectedButton2: Bool, selectedButton3: Bool) {
        
        self.topLeft.isHidden = topLeft
        self.topRight.isHidden = topRight
        self.botLeft.isHidden = botLeft
        self.botRight.isHidden = botRight
        self.selectedButton1.isHidden = selectedButton1
        self.selectedButton2.isHidden = selectedButton2
        self.selectedButton3.isHidden = selectedButton3
        
    }
    
    @IBAction func imagesPicker(_ sender: UIButton) {
        
        self.currentTouchedButtonTag = sender.tag
        libraryPicker()
        
    }
    
    
    private func newLayout() {
        
        centralView.transform = .identity
        centralView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: { self.centralView.transform = .identity })
        
    }
    
    
    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = sourceType
        
        return imagePicker
        
    }
    
    private func libraryPicker() {
        
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
            
            imagePickerController.sourceType = .photoLibrary
            
        } else {
            
            return
            
        }
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let newPicture = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let currentTouchedButton = view.viewWithTag(self.currentTouchedButtonTag) as? UIButton {
                
              
                currentTouchedButton.setImage(newPicture, for: .normal)
            }
            
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func SharesSwipe(_ sender: UISwipeGestureRecognizer) {
        
        if (self.stackViewSwipe.direction == .up) {
            UIView.animate(withDuration: 0.5, animations: {
                 self.centralView.transform = CGAffineTransform(translationX: 0, y: -600)
             })
        }
        else if (self.stackViewSwipe.direction == .left) {
            UIView.animate(withDuration: 0.5, animations: {
                 self.centralView.transform = CGAffineTransform(translationX: -600, y: 0)
             })
        }
        
        
         
        let imageToShare = [self.centralView.takeScreenshot()]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = UIActivityViewController.CompletionWithItemsHandler? { [weak self] activityType, completed, returnedItems, activityError in
                        
            UIView.animate(withDuration: 0.1, animations: {
                self?.centralView.transform = CGAffineTransform(translationX: 0, y: 0)
             })
             
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
}
