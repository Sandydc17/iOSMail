//
//  detailRouter.swift
//  iOSMail
//
//  Created by Sandy Chandra on 15/10/20.
//

import Foundation
import UIKit

class DetailRouter: DetailPresenterToRouter {
    
    func createDetailPage(idEmail: String) -> UIViewController {
        let view = DetailViewController()
        let presenter: DetailViewToPresenter & DetailInteractorToPresenter = DetailPresenter()
        let interactor: DetailPresenterToInteractor = DetailInteractor()
        let router: DetailPresenterToRouter = DetailRouter()
        
        view.idEmail = idEmail
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
