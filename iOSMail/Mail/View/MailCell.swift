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
        
    }
    
    func setupCell(mail: Content) {
        nameLabel.text = mail.from
        subjectLabel.text = mail.subject
        timeLabel.text = convertTime(dateGet: mail.createdAt)
        contentLabel.text = removeHtmlTag(content: mail.preview ?? "")
        readed.isHidden = mail.read 
    }
    
    private func convertTime(dateGet: String) -> String {
        var temp = dateGet
        if let dotRange = temp.range(of: ".") {
          temp.removeSubrange(dotRange.lowerBound..<temp.endIndex)
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE"


        if let date = dateFormatterGet.date(from: temp) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
            return ""
        }
    }
    
    private func removeHtmlTag(content: String) -> String {
        let a = content.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        let b = a.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
        return b
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
