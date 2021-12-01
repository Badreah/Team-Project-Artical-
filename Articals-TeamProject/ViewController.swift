//
//  ViewController.swift
//  Articals-TeamProject
//
//  Created by Badreah Saad on 01/12/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var articlesTabel: UITableView!
    
    var articlesTitle = ""
    var articlesContent = ""
    var selectdCatgre = ""
    
    var articlesArray: [Articles] = []
    var filterArr: [Articles] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesTabel.delegate = self
        articlesTabel.dataSource = self
        loadData()
        
    }
    
    
    @IBAction func SegmentCategory(_ sender: Any) {
        
        filterArr.removeAll()
        switch segmentedControl.selectedSegmentIndex {
        case 0 :
            loadData()
        case 1 :
            for item in articlesArray {
                if item.type == "Health" {
                    self.filterArr.append( item)
                }
                articlesTabel.reloadData() // add reload to relod data for tableview
            }
            print(filterArr)
        case 2 :
            for item in articlesArray {
                if item.type == "Social" {
                    self.filterArr.append( item)
                }
                articlesTabel.reloadData()
            }
        case 3 :
            for item in articlesArray {
                if item.type == "Technical" {
                    self.filterArr.append( item)
                }
                articlesTabel.reloadData()
            }
        default :
            for item in articlesArray {
                if item.type == "All" {
                    self.filterArr.append( item)
                }
                articlesTabel.reloadData()
            }
        }
        
    }
    
    
    @IBAction func createArticles(_ sender: Any) { }
    
    
    func saveData() {
        do{
            try context.save()
        } catch {
            print(error)
        }
        articlesTabel.reloadData()
    }
    
    
    func loadData() {
        let request: NSFetchRequest<Articles> = Articles.fetchRequest()
        do {
            articlesArray = try context.fetch(request)
            
        } catch {
            print(error)
        }
        articlesTabel.reloadData()
    }
    
    
    
}


extension ViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return  articlesArray.count
        } else {
            return filterArr.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = articlesTabel.dequeueReusableCell(withIdentifier: "cell") as! ArticleCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.artTitle.text =  articlesArray[indexPath.row].title
        } else {
            cell.artTitle.text = filterArr[indexPath.row].title
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            deletingAlert(indexPath: indexPath)
        }
        
    }
    
    
    func deletingAlert(indexPath: IndexPath) {
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to delete (\(articlesArray[indexPath.row].title!))", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Delete", style: .default) { _ in
            self.context.delete(self.articlesArray[indexPath.row])
            self.articlesArray.remove(at: indexPath.row)
            self.articlesTabel.deleteRows(at: [indexPath], with: .fade)
            self.saveData()
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        articlesTitle  = articlesArray[indexPath.row].title ?? ""
        articlesContent = articlesArray[indexPath.row].content ?? ""
        performSegue(withIdentifier: "showArt", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showArt" {
            let v = segue.destination as! ShowArticle
            v.articleName = articlesTitle
            v.articalcon = articlesContent
        }
    }
    
    
    
    
}
