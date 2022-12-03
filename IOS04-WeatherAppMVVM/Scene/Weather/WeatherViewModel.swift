//
//  WeatherViewModel.swift
//  IOS04-WeatherAppMVVM
//
//  Created by Mehmet Gökhan Özen on 6.10.2022.
//

import Foundation

struct WeatherViewModel {
    
    private let repository: RepositoryProtocol
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func getWeather(city: String, completion: @escaping (Root) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=69b9e181b79fc3cfa903ebcbed871580&units=metric&q=\(city)"
        repository.request(urlString: urlString,
                           method: .get,
                           success: { (result: Root) in
            completion(result)
        }, failure: { error in
            print(error?.localizedDescription)
        })
        let url = URL(string: "".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)
    }
}


protocol RepositoryProtocol {
    func request<ReturnType: Decodable>(urlString: String,
                                        method: HTTPMethod,
                                        success: @escaping (ReturnType) -> (),
                                        failure: @escaping (Error?) -> ())
}




final class NetworkManager: RepositoryProtocol {
    func request<ReturnType: Decodable>(urlString: String,
                 method: HTTPMethod,success: @escaping (ReturnType) -> (), failure: @escaping (Error?) -> ()) {
        let url = URL.init(string: urlString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let request = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                failure(error)
            }
            
            do {
                let model = try JSONDecoder().decode(ReturnType.self, from: data!)
                success(model)
            } catch {
                failure(error)
            }
            
        }
        request.resume()
    }
}

final class DatabaseManager: RepositoryProtocol {
    func request<ReturnType>(urlString: String, method: HTTPMethod, success: @escaping (ReturnType) -> (), failure: @escaping (Error?) -> ()) where ReturnType : Decodable {
        
    }
    
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}





let xList = Array<Int>()
