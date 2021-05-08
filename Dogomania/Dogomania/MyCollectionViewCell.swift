//
//  MyCollectionViewCell.swift
//  Dogomania
//
//  Created by SWAN mac on 08.05.2021.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with images: [UIImage]) {
        if (images.indices.contains(0)) {
            imageView1.image = images[0]
            imageView1.contentMode = .scaleToFill
        }
        if (images.indices.contains(1)) {
            imageView2.image = images[1]
            imageView2.contentMode = .scaleToFill
        }
        if (images.indices.contains(2)) {
            imageView3.image = images[2]
            imageView3.contentMode = .scaleToFill
        }
        if (images.indices.contains(3)) {
            imageView4.image = images[3]
            imageView4.contentMode = .scaleToFill
        }
        if (images.indices.contains(4)) {
            imageView5.image = images[4]
            imageView5.contentMode = .scaleToFill
        }
        if (images.indices.contains(5)) {
            imageView6.image = images[5]
            imageView6.contentMode = .scaleToFill
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
