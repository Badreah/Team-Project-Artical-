//
//  CreatingArticles.swift
//  Articals-TeamProject
//
//  Created by Badreah Saad on 01/12/2021.
//

import UIKit

class CreatingArticles: UIViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    var articleName: String = ""
    
    @IBOutlet weak var contentField: UITextView!
    var articalcon: String = ""
    
    @IBOutlet weak var segmentCat: UISegmentedControl!
    
    var myArticlesArray: [Articles] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.text = articleName
        contentField.text = articalcon
        
    }
    
    
    @IBAction func addArticles(_ sender: Any) {
        
        let art = Articles(context: context)
        
        print(segmentCat.selectedSegmentIndex)
        
        art.title = titleField.text!
        art.content = contentField.text!
        
        let test = CatgSet(value: segmentCat.selectedSegmentIndex)
        art.type = test
        print(test)
        
        
        do {
            try self.context.save()
        } catch {
            print(error)
        }
        
    }
    
    
    func CatgSet (value:Int) -> String{
        
        switch value{
        case 0:
            return "All"
        case 1:
            return "Health"
        case 2:
            return "Social"
        case 3:
            return "Technical"
        default:
            return "All"
        }
        
    }
    
    
    
    
}
