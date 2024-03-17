//
//  ApiManger.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 10/02/2024.
//

import Foundation
import Combine

/**
 NOMAL API
 */

final public class ApiManger {
    
    public init(){}
    
    private enum ApiError:Error{
        case invalidURL
    }
    
    public func getData<T:Decodable>(url:String,model:T.Type,compleation: @escaping(Result<T,Error>) ->()){
        
        guard  let   url = URL(string: url) else{
            compleation(.failure(ApiError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url){(data,response,error) in
            
            guard  let   data = data else {
                if  let   error = error {compleation(.failure(error))}
                    return
            }
            
            do{
                 let   serverData = try JSONDecoder().decode(T.self, from: data)
                compleation(.success(serverData))
            }catch{
                compleation(.failure(error))
            }
        }.resume()
    }

    
    public  func getDataCombine<T: Decodable>(url: String, model: T.Type) -> AnyPublisher<T, Error> {
        guard  let   url = URL(string: url) else {
            return Fail(error: ApiError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .flatMap { data, response -> AnyPublisher<T, Error> in
                do {
                 let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return Just(decodedData)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
