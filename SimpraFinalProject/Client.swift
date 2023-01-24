

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
