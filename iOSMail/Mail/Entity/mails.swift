//
//  mail.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation

// MARK: - Mails
struct Mails: Codable {
    let content: [Content]
    let empty, first, last: Bool
    let number, numberOfElements: Int
    let pageable: Pageable
    let size: Int
    let sort: Sort
    let totalElements, totalPages: Int
}

// MARK: - Content
struct Content: Codable {
    let attachments, bcc, cc: [String]
    let createdAt, from, id, inboxID: String
    let read: Bool
    let subject: String
    let to: [String]
    var preview: String?

    enum CodingKeys: String, CodingKey {
        case attachments, bcc, cc, createdAt, from, id, preview
        case inboxID = "inboxId"
        case read, subject, to
    }
}

// MARK: - Pageable
struct Pageable: Codable {
    let offset, pageNumber, pageSize: Int
    let paged: Bool
    let sort: Sort
    let unpaged: Bool
}

// MARK: - Sort
struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}

// MARK: - Preview Mail
struct previewMail: Codable {
    var body: String
    
    enum CodingKet: String, CodingKey {
        case body
    }
}
