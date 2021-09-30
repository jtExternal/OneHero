//
//  MarvelAPIService.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

enum MarvelAPIServiceResult {
    case getCharacters([MarvelCharacter])
    case getCharacter(MarvelCharacter)
    case noResults
}

protocol MarvelAPIServiceProtocol {
    func getCharacters(startIndex: Int, maxResults: Int, completion: @escaping (Result<MarvelAPIServiceResult>) -> Void)
    func getCharactersStartingWith(startingWith: String, completion: @escaping (Result<MarvelAPIServiceResult>) -> Void)
    func getCharacter(id: String, completion: @escaping (Result<MarvelAPIServiceResult>) -> Void)
}

/// Logic that will make the network request and trigger callback
struct MarvelAPIService: MarvelAPIServiceProtocol {
    let networkRouter = NetworkRouter<MarvelApiRequest>()
    
    func getCharactersStartingWith(startingWith: String, completion: @escaping (Result<MarvelAPIServiceResult>) -> Void) {
        performAction(BaseMarvelResponse<[MarvelCharacter]>.self, using: .getCharactersStartingWith(nameStartsWith: startingWith)) { result in
            guard result.error == nil else {
                completion(.failure(result.error!))
                return
            }
            
            guard let characters = result.value?.first else {
                completion(.success(.noResults))
                return
            }
            
            if let marvelCharacters = characters.data {
                if marvelCharacters.results.count == 0 {
                    completion(.success(.noResults))
                } else {
                    completion(.success(.getCharacters(marvelCharacters.results)))
                }
            }
        }
    }
    
    func getCharacters(startIndex: Int, maxResults: Int = Configuration.defaultPagingAmt, completion: @escaping (Result<MarvelAPIServiceResult>) -> Void) {
        performAction(BaseMarvelResponse<[MarvelCharacter]>.self, using: .getCharacters(startIndex: startIndex, maxResults: maxResults)) { result in
            guard result.error == nil else {
                completion(.failure(result.error!))
                return
            }
            
            guard let characters = result.value?.first else {
                completion(.success(.noResults))
                return
            }
            
            if let marvelCharacters = characters.data {
                if marvelCharacters.results.count == 0 {
                    completion(.success(.noResults))
                } else {
                    completion(.success(.getCharacters(marvelCharacters.results)))
                }
            }
        }
    }
    
    func getCharacter(id: String, completion: @escaping (Result<MarvelAPIServiceResult>) -> Void) {
        performAction(BaseMarvelResponse<MarvelCharacter>.self, using: .getCharacter(characterId: id)) { result in
            guard result.error == nil else {
                completion(.failure(result.error!))
                return
            }
            
            guard let character = result.value?.first else {
                completion(.success(.noResults))
                return
            }
            
            if let marvelCharacter = character.data {
                completion(.success(.getCharacter(marvelCharacter.results)))
            }
        }
    }
    
    func performAction<T>(_ type: T.Type, using routeType: MarvelApiRequest, completion: @escaping (Result<[T]>) -> Void) where T: Decodable {
        networkRouter.request(routeType) { data, response, error in
            if error != nil {
                Log.e("Please check your network connection.")
                completion(.failure(error!))
            }
            
            if let response = response {
                let result = self.networkRouter.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        Log.e("Failure: \(NetworkResponse.noData.rawValue)")
                        completion(.failure(NetworkResponse.noData))
                        return
                    }
                    
                    do {
                        let receivedResponse = try JSONDecoder().decode(type, from: responseData)
                        Log.i("Did receive response")
                        
                        completion(.success([receivedResponse]))
                    } catch {
                        Log.e(error)
                        completion(.failure(NetworkResponse.unableToDecode))
                    }
                    
                case let .failure(networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    }
}
