//
//  MailInteractor.swift
//  iOSMail
//
//  Created by Sandy Chandra on 13/10/20.
//

import Foundation
import Alamofire

class MailInteractor: MailPresenterToInteractor {
    
    var presenter: MailInteractorToPresenter?
    
    func fetchMail() {
        AF.request(Constant.host + "/emails" + "?apiKey=" + "\(Constant.apiKey)").responseJSON { response in
            if(response.response?.statusCode == 200) {
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let mailResponse = try decoder.decode(Mails.self, from: data)
                    self.presenter?.mailFetchSuccess(mails: mailResponse)

                } catch let error {
                    print(error)
                }
            } else {
                self.presenter?.mailFetchFailed()
            }
        }
        
    }
    
    func fechPrevMail(idEmail: String, index: Int) {
        AF.request(Constant.host + "/emails" + "/\(idEmail)" + "?apiKey=" + Constant.apiKey).response { response in
            if(response.response?.statusCode == 200) {
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let mailResponse = try decoder.decode(previewMail.self, from: data)
                    self.presenter?.prevMailFetchSuccess(content: mailResponse.body, index: index)

                } catch let error {
                    print(error)
                }
                
            } else {
                self.presenter?.prevMailFetchFailed()
            }
        }
    }
    
    func deleteMail(idEmail: String) {
        AF.request(Constant.host + "/emails" + "/\(idEmail)" + "?apiKey=" + Constant.apiKey, method: .delete).response { response in
            self.presenter?.deleteSuccess()
        }
    }
    
    func unreadMail(idEmail: [String], selectedRow: [IndexPath]) {
        //Call API for unread Mail
        self.presenter?.unreadSuccess(selectedRow: selectedRow)

    }
    
    func readMail(idEmail: [String], selectedRow: [IndexPath]) {
        //Call API for read Mail
        self.presenter?.readSuccess(selectedRow: selectedRow)

    }
}
