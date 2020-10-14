//
//  MailProtocol.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation
import UIKit

protocol MailPresenterToView: class {
    func showMail(mail: [Mail])
    func showError()
    func updatePrevEmail(content: String, index: Int)
}

protocol MailInteractorToPresenter: class {
    func mailFetchSuccess(mail: [Mail])
    func mailFetchFailed()
    func prevMailFetchSuccess(content: String, index: Int)
    func prevMailFetchFailed()
}

protocol MailPresenterToInteractor: class {
    var presenter: MailInteractorToPresenter? {get set}
    
    func fetchMail()
    func fechPrevMail(idEmail: String, index: Int)
}

protocol MailViewToPresenter: class {
    var view: MailPresenterToView? {get set}
    var interactor: MailPresenterToInteractor? {get set}
    var router: MailPresenterToRouter? {get set}
    
    func updateView()
    func updateEmail(idEmail: String, index: Int)
}

protocol MailPresenterToRouter: class {
    func createMailPage() -> UIViewController
}
