//
//  GenerationService.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import Alamofire

class GenerationsService {
    fileprivate var baseUrl = ""
    typealias generationsCallBack = (_ Generations:Generations?, _ status: Bool, _ message:String) -> Void
    
    var callBack:generationsCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getAllGenerationsFrom(endPoint:String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "Data not found")

                return}
            do {
            let generations = try JSONDecoder().decode(Generations.self, from: data)
                self.callBack?(generations, true,"")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
            
        }
    }
    
    func completionHandler(callBack: @escaping generationsCallBack) {
        self.callBack = callBack
    }
}
