//
//  DetailInteractor.swift
//  iOSMail
//
//  Created by Sandy Chandra on 15/10/20.
//

import Foundation
import Alamofire

class DetailInteractor: DetailPresenterToInteractor {
    
    var presenter: DetailInteractorToPresenter?
    
    func fetchDetail(idEmail: String) {
        AF.request(Constant.host + "/emails" + "/\(idEmail)" + "?apiKey=" + "\(Constant.apiKey)").responseJSON { response in
            if(response.response?.statusCode == 200) {
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let mailResponse = try decoder.decode(Mail.self, from: data)
                    debugPrint(mailResponse)
                    self.presenter?.fetchDetailSuccess(mail: mailResponse)

                } catch let error {
                    print(error)
                }
            } else {
                self.presenter?.fetchDetailFailed()
            }
        }
    }
    
    
}
