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
        let alert = UIAlertController(title: "Oops!", message: "There's no API to change 'read' message to 'unread' message \n Selected Row \(selectedRow)", preferredStyle: .alert)
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
//        MailTableView.reloadData()
    }
    
    func updatePrevEmail(content: String, index: Int) {
        var mail = mails![index]
        mail.preview = content
        mails![index] = mail
        MailTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    func showMail(mails: Mails) {
        self.mails = mails.content
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
        
    }
}

extension MailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mailCell", for: indexPath) as! MailCell
        cell.setupCell(mail: mails![indexPath.row] as Content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            isTableViewEditing = true
        } else {
            isTableViewEditing = false
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
//                mails?.remove(at: index.row)
            }
            presenter?.deletePressed(idEmails: idEmails)
        }
    }
    
    @objc func unreadPressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            print(selectedRows)
            var idEmails: [String] = []
            presenter?.unreadPressed(idEmails: idEmails, selectedRow: selectedRows!)
        }
    }
//
    @objc func readPressed() {
        let selectedRows = self.MailTableView.indexPathsForSelectedRows
        if(selectedRows != nil) {
            var idEmails: [String] = []
            presenter?.readPressed(idEmails: idEmails, selectedRow: selectedRows!)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.presenter?.updateView()
        }
        
    }
}
