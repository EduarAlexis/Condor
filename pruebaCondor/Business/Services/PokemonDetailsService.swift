//
//  PokemonDetailsService.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import Alamofire

class PokemonDetailsService {
    fileprivate var baseUrl = ""
    typealias firstDetailCallBack = (_ firstDetail:FirstPokemonDetails?, _ status: Bool, _ message:String) -> Void
    
    typealias secondDetailCallBack = (_ secondDetail:SecondPokemonDetails?, _ status: Bool, _ message:String) -> Void
    
    var firstCallBack:firstDetailCallBack?
    var secondCallBack:secondDetailCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getFirstDetailPokemonFrom(endPoint:String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.firstCallBack?(nil, false, "Data not found")

                return}
            do {
            let firstDetail = try JSONDecoder().decode(FirstPokemonDetails.self, from: data)
                self.firstCallBack?(firstDetail, true,"")
            } catch {
                self.firstCallBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func getSecondDetailPokemonFrom(endPoint:String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.secondCallBack?(nil, false, "Data not found")

                return}
            do {
            let secondDetail = try JSONDecoder().decode(SecondPokemonDetails.self, from: data)
                self.secondCallBack?(secondDetail, true,"")
            } catch {
                self.secondCallBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func firstCompletionHandler(firstCallBack: @escaping firstDetailCallBack) {
        self.firstCallBack = firstCallBack
    }
    
    func secondCompletionHandler(secondCallBack: @escaping secondDetailCallBack) {
        self.secondCallBack = secondCallBack
    }
}
