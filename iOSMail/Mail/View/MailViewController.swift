//
//  MailViewController.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import UIKit

class MailViewController: UIViewController {

    @IBOutlet weak var HeaderLabel: UILabel!
    @IBOutlet weak var MailTableView: UITableView!
    
    var presenter: MailViewToPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension MailViewController: MailPresenterToView {
    
    func showMail(mail: Mail) {
        
    }
    
    func showError() {
        
    }
}

extension MailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailCell", for: indexPath) as! MailCell
        cell.setupDummyCell(index: indexPath.row)
//        cell.setupCell(mail: mail)
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            MailTableView.reloadData()
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        MailTableView.setEditing(editing, animated: true)
        if editing {
            self.navigationController?.setToolbarHidden(false, animated: true)
        } else {
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }
    
    
}


extension MailViewController {
    func setupView() {
        HeaderLabel.text = "Inbox"
        
        MailTableView.delegate = self
        MailTableView.dataSource = self
        MailTableView.allowsMultipleSelectionDuringEditing = true
        
        self.navigationItem.rightBarButtonItem = editButtonItem

        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(deletePressed))
        let readButton: UIBarButtonItem = UIBarButtonItem(title: "read", style: .plain, target: self, action: #selector(deletePressed))
        let unreadButton: UIBarButtonItem = UIBarButtonItem(title: "unread", style: .plain, target: self, action: #selector(deletePressed))
        self.toolbarItems = [readButton, flexible, unreadButton, flexible, deleteButton]
        self.navigationController?.toolbar.barTintColor = UIColor.white
        
        let nib = UINib(nibName: "MailCell", bundle: nil)
        self.MailTableView.register(nib, forCellReuseIdentifier: "mailCell")
    }
    
    @objc func deletePressed() {
//        let selectedRows = self.MailTableView.indexPathsForSelectedRows
//        if selectedRows != nil {
//            for var selectionIndex in selectedRows! {
////                while selectionIndex.item >= vegetables.count {
////                    selectionIndex.item -= 1
////                }
//                MailTableView(MailTableView, commit: .delete, forRowAt: selectionIndex)
//            }
//        }
    }
    
//    @objc func unreadPressed() {
//        let selectedRows = self.MailTableView.indexPathsForSelectedRows
//        if selectedRows != nil {
//            for var selectionIndex in selectedRows! {
//                while selectionIndex.item >= vegetables.count {
//                    selectionIndex.item -= 1
//                }
//                MailTableView(MailTableView, commit: .none, forRowAt: selectionIndex)
//            }
//        }
//    }
//
//    @objc func readPressed() {
//        let selectedRows = self.MailTableView.indexPathsForSelectedRows
//        if selectedRows != nil {
//            for var selectionIndex in selectedRows! {
//                while selectionIndex.item >= vegetables.count {
//                    selectionIndex.item -= 1
//                }
//                MailTableView(MailTableView, commit: .none, forRowAt: selectionIndex)
//            }
//        }
//    }
}
