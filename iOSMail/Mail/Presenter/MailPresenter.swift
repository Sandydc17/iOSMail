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

}

extension MailPresenter: MailInteractorToPresenter {
    
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


