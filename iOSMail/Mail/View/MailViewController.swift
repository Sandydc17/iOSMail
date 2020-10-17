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
    var isTableViewEditing: Bool = false
    
    private var mails: [Content]?
    private var unreadMails: [Content] = []
    
    private var isFilterUnread: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.beginRefreshing()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        presenter?.updateView()
    }

}

extension MailViewController: MailPresenterToView {
    func unreadSuccess(selectedRow: [IndexPath]) {
        let alert = UIAlertController(title: "Oops!", message: "There's no API to change 'read' message to 'unread' message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func readSuccess(selectedRow: [IndexPath]) {
        let alert = UIAlertController(title: "Oops!", message: "There's no API to change 'unread' message to 'read' message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func deleteSuccess() {
        presenter?.updateView()
    }
    
    func updatePrevEmail(content: String, index: Int) {
        var mail = mails![index]
        mail.preview = content
        mails![index] = mail
        MailTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    func showMail(mails: Mails) {
        self.mails = mails.content
        
        for mail in self.mails! {
            print(mail.read)
            if(mail.read == false) {
                unreadMails.append(mail)
            }
        }
        
        for mail in unreadMails {
            print(mail.id)
        }
        
        MailTableView.reloadData()
        var count = 0
        for mail in self.mails! {
            self.presenter?.updateEmail(idEmail: mail.id, index: count)
            count+=1
            
        }
        MailTableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    func showError() {
        let alert = UIAlertController(title: "Oops!", message: "Failed to fetch Email", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension MailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterUnread {
            return unreadMails.count
        } else {
            return mails?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailCell", for: indexPath) as! MailCell
        if isFilterUnread {
            cell.setupCell(mail: unreadMails[indexPath.row] as Content)
        } else {
            cell.setupCell(mail: mails![indexPath.row] as Content)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            isTableViewEditing = true
            setUIBar()
            
        } else {
            isTableViewEditing = false
            setUIBar()
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            MailTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isTableViewEditing {
            if let selectedMail = mails?[indexPath.item] {
                presenter?.selectedMail(idEmail: selectedMail.id, index: indexPath.row)
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if isEditing {
            isTableViewEditing = true
            setUIBar()
            
        } else {
            isTableViewEditing = false
            setUIBar()
        }
        MailTableView.setEditing(editing, animated: true)
        
    }
}


extension MailViewController {
    func setupView() {
        HeaderLabel.text = "Inbox"
        
        MailTableView.delegate = self
        MailTableView.dataSource = self
        MailTableView.allowsMultipleSelectionDuringEditing = true
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        self.navigationController?.toolbar.barTintColor = UIColor.white
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        MailTableView.addSubview(refreshControl)
        
        let nib = UINib(nibName: "MailCell", bundle: nil)
        self.MailTableView.register(nib, forCellReuseIdentifier: "mailCell")
        
        setUIBar()
    }
    
    func setUIBar() {
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed))
        let readButton: UIBarButtonItem = UIBarButtonItem(title: "Mark as read", style: .plain, target: self, action: #selector(unreadPressed))
        let unreadButton: UIBarButtonItem = UIBarButtonItem(title: "Mark as unread", style: .plain, target: self, action: #selector(readPressed))
        let filterUnreadButton: UIBarButtonItem = UIBarButtonItem(title: "Filter Unread", style: .plain, target: self, action: #selector(filterUnread))
        
        if isTableViewEditing {
            self.toolbarItems = [readButton, flexible, unreadButton, flexible, deleteButton]
        } else {
            self.toolbarItems = [filterUnreadButton, flexible, deleteButton]
        }
    }
    
    @objc func deletePressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            var idEmails: [String] = []
            for index in selectedRows! {
                let mail = mails![index.row]
                idEmails.append(mail.id)
            }
            presenter?.deletePressed(idEmails: idEmails)
        }
    }
    
    @objc func unreadPressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            let idEmails: [String] = []
            presenter?.unreadPressed(idEmails: idEmails, selectedRow: selectedRows!)
        }
    }
//
    @objc func readPressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            let idEmails: [String] = []
            presenter?.readPressed(idEmails: idEmails, selectedRow: selectedRows!)
        }
    }
    
    @objc func filterUnread() {
        if isFilterUnread {
            print("IS FALSE")
            isFilterUnread = false
        } else {
            print("IS TRUE")
            isFilterUnread = true
        }
        MailTableView.reloadData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.presenter?.updateView()
        }
        isFilterUnread = false
        
    }
}
