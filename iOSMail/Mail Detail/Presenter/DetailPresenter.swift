//
//  DetailPresenter.swift
//  iOSMail
//
//  Created by Sandy Chandra on 15/10/20.
//

import Foundation

class DetailPresenter: DetailViewToPresenter {
    
    var view: DetailPresenterToView?
    var interactor: DetailPresenterToInteractor?
    var router: DetailPresenterToRouter?
    
    func updateView(idEmail: String) {
        interactor?.fetchDetail(idEmail: idEmail)
    }
    
    
}

extension DetailPresenter: DetailInteractorToPresenter {
    
    func fetchDetailSuccess(mail: Mail) {
        view?.showDetail(mail: mail)
    }
    
    func fetchDetailFailed() {
        
    }
    
    
}
