//
//  detailProtocol.swift
//  iOSMail
//
//  Created by Sandy Chandra on 15/10/20.
//

import Foundation
import UIKit

protocol DetailPresenterToView: class {
    func showDetail(mail: Mail)
    func fetchDetailFailed()
}

protocol DetailInteractorToPresenter: class {
    func fetchDetailSuccess(mail: Mail)
    func fetchDetailFailed()
}

protocol DetailPresenterToInteractor: class {
    var presenter: DetailInteractorToPresenter? {get set}
    
    func fetchDetail(idEmail: String)
}

protocol DetailViewToPresenter: class {
    var view: DetailPresenterToView? {get set}
    var interactor: DetailPresenterToInteractor? {get set}
    var router: DetailPresenterToRouter? {get set}
    
    func updateView(idEmail: String)
}

protocol DetailPresenterToRouter: class {
    func createDetailPage(idEmail: String) -> UIViewController
}

