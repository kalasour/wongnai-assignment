//
//  TableViewController.swift
//  wongnai_assignment
//
//  Created by Nuntawat. Wisedsup on 7/11/2562 BE.
//  Copyright © 2562 Nuntawat. Wisedsup. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var gotData: Item?
    var photos: [Photo]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        fetchData(handler: { [weak self] data in
            self?.fetched(data:data)
        })
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        fetchData(handler: { [weak self] data in
            self?.fetched(data:data)
        })
        sender.endRefreshing()
    }
    
    func fetched(data:Item?) {
        gotData = data
        if let inData = gotData {
            photos = inData.photos
            print("Fetched data.")
        }else {
            print("Can not get data.")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func fetchData(handler: @escaping ((_ data:Item?)->Void)) {
        if let url = URL(string: "https://api.500px.com/v1/photos?feature=popular&page=1") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Item.self, from: data)
                        handler(res)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if let unwrapPhotos = photos {
            return unwrapPhotos.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as? TableViewCell else { return UITableViewCell() }
        if let unwrapPhotos = photos {
            cell.name.text = (unwrapPhotos[indexPath.row].name)!
            cell.voted.text = ((unwrapPhotos[indexPath.row].positive_votes_count)!).delimiter
            cell.detail.text = (unwrapPhotos[indexPath.row].description)!
        }else {
            print("can not get photos")
        }
        
        
        
        if let imageURL = URL(string: (photos![indexPath.row].image_url)![0]) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.img.image = image
                        cell.img.layer.masksToBounds = true
                    }
                }
            }
        }
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
