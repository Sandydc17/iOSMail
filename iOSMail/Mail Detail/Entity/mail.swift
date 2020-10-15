//
//  mail.swift
//  iOSMail
//
//  Created by Sandy Chandra on 15/10/20.
//

import Foundation

// MARK: - Mail
struct Mail: Codable {
    let attachments, bcc: [String]
    let body: String
    let cc: [String]
    let charset, createdAt, from: String
    let id, inboxID: String
    let isHTML, read: Bool
    let subject: String
    let to: [String]
    let updatedAt, userID: String

    enum CodingKeys: String, CodingKey {
        case attachments, bcc, body, cc, charset, createdAt, from, id
        case inboxID = "inboxId"
        case isHTML, read, subject, to, updatedAt
        case userID = "userId"
    }
}
