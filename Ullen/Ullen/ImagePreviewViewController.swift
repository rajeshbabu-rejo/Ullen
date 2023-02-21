//
//  ImagePreviewViewController.swift
//  Ullen
//
//  Created by Rajesh Babu on 19/02/23.
//

import Foundation
import UIKit

class ImagePreviewViewController : UIViewController {
    
    var capturedImage : UIImage?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = capturedImage
    }
}
