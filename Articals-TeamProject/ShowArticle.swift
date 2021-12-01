//
//  ShowArticle.swift
//  Articals-TeamProject
//
//  Created by Badreah Saad on 01/12/2021.
//

import UIKit

class ShowArticle: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    var articleName: String = ""

    
    @IBOutlet weak var articleLabel: UITextView!
    var articalcon: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = articleName
        articleLabel.text = articalcon
   
    }
   

}
