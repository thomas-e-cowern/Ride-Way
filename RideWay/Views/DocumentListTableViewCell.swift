//
//  DocumentListTableViewCell.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/19/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class DocumentListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var documentCellImage: UIImageView!
    @IBOutlet weak var documentTextlabel: UILabel!
    
    var document: Documentation? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        print("DLTVC: \(String(describing: document?.documentationImageUrl))")
        guard let document = document else { return }
        guard let url = document.documentationImageUrl else { return }
        
        DocumentController.shared.loadImagages(url: url) { (image) in
            print("Was an image returned?")
            DispatchQueue.main.async {
                self.documentCellImage.image = image
            }
        }
        
        DispatchQueue.main.async {
             self.documentTextlabel.text = document.name
        }
    }
}
