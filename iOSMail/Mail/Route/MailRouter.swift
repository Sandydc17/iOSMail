//
//  MailRouter.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation
import UIKit

class MailRouter: MailPresenterToRouter {
    
    func createMailPage() -> UIViewController {
        let view = MailViewController()
        let presenter: MailViewToPresenter & MailInteractorToPresenter = MailPresenter()
        let interactor: MailPresenterToInteractor = MailInteractor()
        let router: MailPresenterToRouter = MailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func presentDetailMail(view: MailPresenterToView, idEmail: String) {
        let detailRouter = DetailRouter()
        let detailView = detailRouter.createDetailPage(idEmail: idEmail)
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        viewVC.present(detailView, animated: true)
    }
    
}
