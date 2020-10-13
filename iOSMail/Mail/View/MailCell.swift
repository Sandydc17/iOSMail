//
//  MailCell.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import UIKit

class MailCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var readed: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(mail: Mail) {
        nameLabel.text = mail.from[0].name
        subjectLabel.text = mail.subject
        timeLabel.text = mail.received
        contentLabel.text = "content email cont ent email con tent email cont ent email cont ent email con tent email"
        readed.isHidden = mail.read ?? false
    }
    
    func setupDummyCell(index: Int) {
        nameLabel.text = "Sandy Chandra"
        subjectLabel.text = "ini merupakan subject email"
        timeLabel.text = "Sunday"
        contentLabel.text = "content email cont ent email con tent email con tent email cont ent email cont ent email"
        if(index % 2 == 0) {
            readed.isHidden = true
        } else {
            readed.isHidden = false
        }
    }
    
//    func countTime(date: String) -> String {
//
//
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
