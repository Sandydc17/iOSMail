//
//  MailPresenter.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation

class MailPresenter: MailViewToPresenter {
    
    
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
        //Call interactor for request READ function
        interactor?.readMail(idEmail: idEmails, selectedRow: selectedRow)
    }
    
    func unreadPressed(idEmails: [String], selectedRow: [IndexPath]) {
        //Call interactor for request READ function
        interactor?.readMail(idEmail: idEmails, selectedRow: selectedRow)
    }
    
    func selectedMail(idEmail: String, index: Int) {
        router?.presentDetailMail(view: view!, idEmail: idEmail)
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
    
    func mailFetchSuccess(mails: Mails) {
        view?.showMail(mails: mails)
    }
    
    func mailFetchFailed() {
        
    }
    
    
}


