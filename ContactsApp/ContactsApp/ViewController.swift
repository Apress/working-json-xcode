//
//  ViewController.swift
//  ContactsApp
//
//  Created by Tihomir RAdeff on 13.10.20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableItems: [TableItems] = []
    
    let ourUrl = "https://radefffactory.com/VideoTutorial/contacts.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadData(link: ourUrl)
    }

    func downloadData(link: String) {
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let status = try? JSONDecoder().decode(Items.self, from: data) {
                        for i in status.contacts {
                            let item = TableItems()
                            item.name = i.name
                            item.phone = i.phone
                            item.address = i.address
                            item.email = i.email
                            self.tableItems.append(item)
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell") as! TableViewCell
        
        cell.nameLabel.text = "Name: " + tableItems[indexPath.row].name
        cell.phoneLabel.text = "Phone: " + tableItems[indexPath.row].phone
        cell.addressLabel.text = "Address: " + tableItems[indexPath.row].address
        cell.emailLabel.text = "Email: " + tableItems[indexPath.row].email
        
        return cell
    }
}

