//
//  GenerationService.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import Alamofire

class GenerationService {
    fileprivate var baseUrl = ""
    typealias generationCallBack = (_ generation:Generation?, _ status: Bool, _ message:String) -> Void
    
    var callBack:generationCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getGenerationsFrom(endPoint:String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "Data not found")
                return}
            do {
            let generation = try JSONDecoder().decode(Generation.self, from: data)
                self.callBack?(generation, true,"")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
            
        }
    }
    
    func completionHandler(callBack: @escaping generationCallBack) {
        self.callBack = callBack
    }
}
