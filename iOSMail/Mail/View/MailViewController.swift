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
    
    lazy var refreshControl = UIRefreshControl()
    
    var presenter: MailViewToPresenter?
    
    private var mails: [Mail]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshControl.beginRefreshing()
        presenter?.updateView()
    }

}

extension MailViewController: MailPresenterToView {
    func unreadSuccess(selectedRow: [IndexPath]) {
        MailTableView.reloadRows(at: selectedRow, with: .automatic)
    }
    
    func readSuccess(selectedRow: [IndexPath]) {
        MailTableView.reloadRows(at: selectedRow, with: .automatic)
    }
    
    
    func deleteSuccess() {
        MailTableView.reloadSections([0], with: .automatic)
    }
    
    func updatePrevEmail(content: String, index: Int) {
        var mail = mails![index]
        mail.content = content
        mails![index] = mail
        MailTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    func showMail(mail: [Mail]) {
        self.mails = mail
        self.MailTableView.reloadData()
        var count = 0
        for mail in self.mails! {
            self.presenter?.updateEmail(idEmail: mail.id, index: count)
            count+=1
        }
//        mails = mail
//        MailTableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    func showError() {
        
    }
}

extension MailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailCell", for: indexPath) as! MailCell
        cell.setupCell(mail: mails![indexPath.row])
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
        let readButton: UIBarButtonItem = UIBarButtonItem(title: "read", style: .plain, target: self, action: #selector(unreadPressed))
        let unreadButton: UIBarButtonItem = UIBarButtonItem(title: "unread", style: .plain, target: self, action: #selector(readPressed))
        self.toolbarItems = [readButton, flexible, unreadButton, flexible, deleteButton]
        self.navigationController?.toolbar.barTintColor = UIColor.white
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        MailTableView.addSubview(refreshControl)
        
        let nib = UINib(nibName: "MailCell", bundle: nil)
        self.MailTableView.register(nib, forCellReuseIdentifier: "mailCell")
    }
    
    @objc func deletePressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            var idEmails: [String] = []
            for index in selectedRows! {
                let mail = mails![index.row]
                idEmails.append(mail.id)
                mails?.remove(at: index.row)
            }
            presenter?.deletePressed(idEmails: idEmails)
        }
    }
    
    @objc func unreadPressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            var idEmails: [String] = []
            for index in selectedRows! {
                var mail = mails![index.row]
                mail.read = false
                mails![index.row] = mail
                idEmails.append(mail.id)
                
            }
            presenter?.unreadPressed(idEmails: idEmails, selectedRow: selectedRows!)
        }
    }
//
    @objc func readPressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            var idEmails: [String] = []
            for index in selectedRows! {
                var mail = mails![index.row]
                mail.read = true
                mails![index.row] = mail
                idEmails.append(mail.id)
            }
            presenter?.readPressed(idEmails: idEmails, selectedRow: selectedRows!)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.presenter?.updateView()
        }
        
    }
}
