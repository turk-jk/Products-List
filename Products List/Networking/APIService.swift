//
//  APIService.swift
//  Products List
//
//  Created by yacob kazal on 7/2/2023.
//

import Combine
import Foundation

final class APIService {
    private var session: URLSessionProtocol

    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    private func fetch<T: Codable>(endPoint: Endpoints)-> AnyPublisher<T, NetworkError> {
        return Future { [weak self] completion in
            guard let self = self,
                  let url = URL(string: endPoint.url) else{
                completion(.failure(.badURL))
                return
            }
            let dataTask = self.session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(.other(error)))
                    return
                }
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    completion(.failure(.unhandledCode("no statusCode")))
                    return
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                switch statusCode {
                case 200:
                    do{
                        let response = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(response))
                        
                    }catch let error as NSError{
                        print(error.userInfo)
                        completion(.failure(.badData))
                    }
                case 404:
                    completion(.failure(.badURL))
                default:
                    completion(.failure(.unhandledCode("statusCode: \(statusCode)")))
                }
            }

            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func fetchProducts() -> AnyPublisher<ProductResponse, NetworkError> {
        fetch(endPoint: .products)
    }
}

