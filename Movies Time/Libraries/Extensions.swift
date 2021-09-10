//
//  Extensions.swift
//  Movies Time
//
//  Created by Jose Enrique Montañez Villanueva on 05/09/21.
//

import UIKit

extension UIImageView {
    
    func setImageFrom(imagePath: String, completion: @escaping () -> Void) {
        NetworkProvider.shared.retrieveImageFor(imagePath: imagePath) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
                completion()
            }
        }
    }
    
}


