//
//  MailPresenter.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation

class MailPresenter: MailViewToPresenter {
    
    
//    public var dataMail: [Mail]?
//    public var dataContent: [String]?
    
    var view: MailPresenterToView?
    var interactor: MailPresenterToInteractor?
    var router: MailPresenterToRouter?
    
    func updateView() {
        interactor?.fetchMail()
    }

    func updateEmail(idEmail: String, index: Int) {
        interactor?.fechPrevMail(idEmail: idEmail, index: index)
    }
    
    func deletePressed(idEmails: [String]) {
        for email in idEmails {
            interactor?.deleteMail(idEmail: email)
        }
    }
    
    func readPressed(idEmails: [String], selectedRow: [IndexPath]) {
        for email in idEmails {
            interactor?.readMail(idEmail: email, selectedRow: selectedRow)
        }
    }
    
    func unreadPressed(idEmails: [String], selectedRow: [IndexPath]) {
        for email in idEmails {
            interactor?.unreadMail(idEmail: email, selectedRow: selectedRow)
        }
    }

}

extension MailPresenter: MailInteractorToPresenter {
    func unreadSuccess(selectedRow: [IndexPath]) {
        view?.unreadSuccess(selectedRow: selectedRow)
    }
    
    func readSuccess(selectedRow: [IndexPath]) {
        view?.readSuccess(selectedRow: selectedRow)
    }
    
    
    func deleteSuccess() {
        view?.deleteSuccess()
    }
    
    
    func prevMailFetchSuccess(content: String, index: Int) {
        view?.updatePrevEmail(content: content, index: index)
    }
    
    func prevMailFetchFailed() {
        
    }
    
    func mailFetchSuccess(mail: [Mail]) {
//        dataMail = mail
//        for mailItem in dataMail! {
//       }
        
        view?.showMail(mail: mail)
    }
    
    func mailFetchFailed() {
        
    }
    
    
}


