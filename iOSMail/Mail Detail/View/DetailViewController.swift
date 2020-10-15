//
//  DetailViewController.swift
//  iOSMail
//
//  Created by Sandy Chandra on 15/10/20.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter: DetailViewToPresenter?
    
    public var idEmail: String?
    var mail: Mail?
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView(idEmail: idEmail ?? "")
        setupView()
        
    }
    

}

extension DetailViewController: DetailPresenterToView {
    func showDetail(mail: Mail) {
        self.mail = mail
        setupContent()
    }
    
    
}


extension DetailViewController {
    func setupContent() {
        fromLabel.text = mail?.from
        toLabel.text = mail?.to[0]
        timeLabel.text = mail?.createdAt
        subjectLabel.text = mail?.subject
        bodyLabel.attributedText = mail?.body.htmlToAttributedString
    }
    
    func setupView() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        
        let navItem = UINavigationItem(title: "")
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(backPressed))
        navItem.rightBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
