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
    
}

extension MailPresenter: MailInteractorToPresenter {
    func mailFetchSuccess(mail: Mail) {
        
    }
    
    func mailFetchFailed() {
        
    }
    
    
}


