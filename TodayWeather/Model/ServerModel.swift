//
//  ServerModel.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ServerModel: NSObject {

    static let shared = ServerModel()
    
    private let baseUrlString = "https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/"

    func forecast(location: Location ,completion: @escaping (Result<Forecast, ServerError>) -> Void) {
        
        let locationString = "\(location.latitude),\(location.longitude)"
        let urlString = baseUrlString + locationString
        let url = URL(string: urlString)
        
        print("urlString: \(urlString)")
        
        request(url: url, completion: completion)
    }
    
    func request<T: Decodable>(url: URL?, completion: @escaping (Result<T, ServerError>) -> Void) {
        guard let url = url else {
            completion(.failure(.url))
            return
        }
   
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.api))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<299 ~= response.statusCode else {
                completion(.failure(.respone))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            //print("data: \(String(describing: String(data: data, encoding: .utf8)))")
            
            do {
                let values = try JSONDecoder().decode(T.self, from: data)
                completion(.success(values))
            } catch {
                completion(.failure(.decoder))
            }
        }.resume()
    }
}

//MARK: - Enum
extension ServerModel {
    enum ServerError: Error {
        case api
        case url
        case respone
        case noData
        case decoder
    }
}
