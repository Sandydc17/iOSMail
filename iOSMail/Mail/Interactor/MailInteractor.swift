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
                    debugPrint(data)
                    let decoder = JSONDecoder()
                    let mailResponse = try decoder.decode(Array<Mail>.self, from: data)
//                        guard let genreItems = genreResponse.genres else{return}
//                        debugPrint(mailResponse)
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
}
