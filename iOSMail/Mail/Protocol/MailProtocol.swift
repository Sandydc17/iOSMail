//
//  MailProtocol.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation
import UIKit

protocol MailPresenterToView: class {
    func showMail(mail: Mail)
    func showError()
}

protocol MailInteractorToPresenter: class {
    func mailFetchSuccess(mail: Mail)
    func mailFetchFailed()
}

protocol MailPresenterToInteractor: class {
    var presenter: MailInteractorToPresenter? {get set}
    
    func fetchMail()
}

protocol MailViewToPresenter: class {
    var view: MailPresenterToView? {get set}
    var interactor: MailPresenterToInteractor? {get set}
    var router: MailPresenterToRouter? {get set}
}

protocol MailPresenterToRouter: class {
    func createMailPage() -> UIViewController
}
