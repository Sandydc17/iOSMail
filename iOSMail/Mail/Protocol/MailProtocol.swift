//
//  MailProtocol.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation
import UIKit

protocol MailPresenterToView: class {
    func showMail(mails: Mails)
    func showError()
    func updatePrevEmail(content: String, index: Int)
    func deleteSuccess()
    func unreadSuccess(selectedRow: [IndexPath])
    func readSuccess(selectedRow: [IndexPath])
}

protocol MailInteractorToPresenter: class {
    func mailFetchSuccess(mails: Mails)
    func mailFetchFailed()
    func prevMailFetchSuccess(content: String, index: Int)
    func prevMailFetchFailed()
    func deleteSuccess()
    func unreadSuccess(selectedRow: [IndexPath])
    func readSuccess(selectedRow: [IndexPath])
}

protocol MailPresenterToInteractor: class {
    var presenter: MailInteractorToPresenter? {get set}
    
    func fetchMail()
    func fechPrevMail(idEmail: String, index: Int)
    func deleteMail(idEmail: String)
    func unreadMail(idEmail: [String], selectedRow: [IndexPath])
    func readMail(idEmail: [String], selectedRow: [IndexPath])
}

protocol MailViewToPresenter: class {
    var view: MailPresenterToView? {get set}
    var interactor: MailPresenterToInteractor? {get set}
    var router: MailPresenterToRouter? {get set}
    
    func updateView()
    func updateEmail(idEmail: String, index: Int)
    func deletePressed(idEmails: [String])
    func readPressed(idEmails: [String], selectedRow: [IndexPath])
    func unreadPressed(idEmails: [String], selectedRow: [IndexPath])
    func selectedMail(idEmail: String, index: Int)
}

protocol MailPresenterToRouter: class {
    func createMailPage() -> UIViewController
    func presentDetailMail(view: MailPresenterToView, idEmail: String)
}
