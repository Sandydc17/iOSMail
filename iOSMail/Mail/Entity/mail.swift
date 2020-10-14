//
//  mail.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation

struct Mail: Codable {
    let id: String
    let from, to: [From]
    let cc, bcc: [String]
    let subject: String?
    let inbox, originalInbox, domain, received: String?
    let size: Int
    let attachments: [String]
    let ip, via, folder: String
    let labels: [String]
    let read: Bool?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case from, to, cc, bcc, subject, inbox, originalInbox, domain, received, size, attachments, ip, via, folder, labels, read, content
    }
}

struct From: Codable {
    let address, name: String
}

struct MailPrev: Codable {
    let content: String
}
