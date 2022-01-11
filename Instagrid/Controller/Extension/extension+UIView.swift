//
//  extension+UIView.swift
//  Instagrid
//
//  Created by Aymerik Vallejo on 08/11/2021.
//


import UIKit

extension UIView {

    func takeScreenshot() -> UIImage {

        // Context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Dessin de la view dans le context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // on Récupère l'image
        let currentImageContext = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let image = currentImageContext {
            return image
        }
        return UIImage()
    }
}
