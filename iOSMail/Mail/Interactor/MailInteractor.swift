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
        AF.request(Constant.host + "addresses/" + Constant.emailDummy + "/messages" + "?_mailsacKey=" + Constant.apiKey).response { response in
            if(response.response?.statusCode == 200) {
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let mailResponse = try decoder.decode(Array<Mail>.self, from: data)
//                        guard let genreItems = genreResponse.genres else{return}
                        debugPrint(mailResponse)
                    self.presenter?.mailFetchSuccess(mail: mailResponse)
//                        self.presenter?.genreFetchSuccess(genre: genreItems)

                } catch let error {
                    print(error)
                }
            } else {
                self.presenter?.mailFetchFailed()
            }
        }
    }
    
    func fechPrevMail(idEmail: String, index: Int) {
        AF.request(Constant.host + "text/" + Constant.emailDummy + "/\(idEmail)" + "?_mailsacKey=" + Constant.apiKey).response { response in
            if(response.response?.statusCode == 200) {
                guard let data = response.data else { return }
                let content = String(decoding: data, as: UTF8.self)
                self.presenter?.prevMailFetchSuccess(content: content, index: index)
            } else {
                self.presenter?.prevMailFetchFailed()
            }
        }
    }
    
    func deleteMail(idEmail: String) {
        AF.request(Constant.host + "addresses/" + Constant.emailDummy + "/messages" + "/\(idEmail)" + "?_mailsacKey=" + Constant.apiKey, method: .delete).response { response in
            if(response.response?.statusCode == 200) {
                self.presenter?.deleteSuccess()
            } else {
                
            }
        }
    }
    
    func unreadMail(idEmail: String, selectedRow: [IndexPath]) {
        AF.request(Constant.host + "addresses/" + Constant.emailDummy + "/messages" + "/\(idEmail)" + "/read/false" + "?_mailsacKey=" + Constant.apiKey, method: .delete).response { response in
            if(response.response?.statusCode == 200) {
                self.presenter?.unreadSuccess(selectedRow: selectedRow)
            } else {
                
            }
        }
    }
    
    func readMail(idEmail: String, selectedRow: [IndexPath]) {
        AF.request(Constant.host + "addresses/" + Constant.emailDummy + "/messages" + "/\(idEmail)" + "/read/false" + "?_mailsacKey=" + Constant.apiKey, method: .delete).response { response in
            if(response.response?.statusCode == 200) {
                self.presenter?.readSuccess(selectedRow: selectedRow)
            } else {
                
            }
        }
    }
}
