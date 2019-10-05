//
//  MainViewController.swift
//  RishabhConnect
//
//  Created by Rishabh Bendiganavale on 6/26/19.
//  Copyright © 2019 Rishabh Bendiganavale. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UITableViewController {
    var loginRegisterController: LoginRegisterController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))

        // observeMessages()
    }
    
//    var messages = [Message]()
//    func observeMessages() {
//        let ref = Database.database().reference().child("messages")
//
//        ref.observe(.childAdded) { (snapshot) in
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let message = Message(dictionary: dictionary)
//                self.messages.append(message)
//                print("message")
//
//                DispatchQueue.main.async(execute: {
//                    self.tableView.reloadData()
//                })
//            }
//        }
//    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNewMessage() {
        return
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // messages.count
    }


}
