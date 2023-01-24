//
//  Client.swift
//  LegendaryApp
//
//  Created by Furkan Deniz Albaylar on 22.01.2023.
//

import Foundation
import Alamofire

struct Headers {
    
    static let apiKey = "c219f28a485d4caeaf74e4116b310e0e"
}


final class RawgClient {
    static let baseUrl = "https://rawg.io/api/games"
    static let apiUrl = "https://api.rawg.io/api/games"
    
    static func getPopularGames(completion: @escaping ([RawgModel]?, Error?) -> Void) {
        let urlString = baseUrl + "/lists/main?discover=true&ordering=-relevance&page_size=40&page=1" + "&key=" + Headers.apiKey
        handleResponse(urlString: urlString, responseType: GetRawgResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    static func searchGames(gameName:String, completion: @escaping ([RawgModel]?, Error?) -> Void) {
        let encodedString = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "*"
        let urlString = apiUrl + "?search_precise=true" + "&search=" + encodedString + "&key=" + Headers.apiKey
        handleResponse(urlString: urlString, responseType: GetRawgResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
