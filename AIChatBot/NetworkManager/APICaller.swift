//
//  APICaller.swift
//  AIChatBot
//
//  Created by Ahmet Ali ÇETİN on 27.07.2023.
//

import Foundation
import OpenAISwift

class APICaller {
    static let shared = APICaller()
    
    private var config: OpenAISwift.Config
    private var client: OpenAISwift?
    
    private init() {
        config = OpenAISwift.Config.makeDefaultOpenAI(apiKey: Constants.API_KEY)
    }
    
    public func setup() {
        client = OpenAISwift(config: config)
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        guard let client = client else {
            completion(.failure(.clientNotSetUp))
            return
        }
        
        client.sendCompletion(with: input, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                guard let output = model.choices?.first?.text else {
                    completion(.failure(.invalidResponse))
                    return
                }
                completion(.success(output))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.genericError))
            }
        })
    }
}

enum OpenAIError: Error {
    case genericError
    case invalidResponse
    case clientNotSetUp
    
    
    var localizedDescription: String {
        switch self {
        case .genericError:
            return "Bir hata oluştu."
        case .invalidResponse:
            return "Geçersiz bir yanıt alındı."
        case .clientNotSetUp:
            return "OpenAI istemci düzgün bir şekilde ayarlanmadı."
            
        }
    }
}
