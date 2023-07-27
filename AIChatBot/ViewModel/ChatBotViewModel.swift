//
//  ChatBotViewModel.swift
//  AIChatBot
//
//  Created by Ahmet Ali ÇETİN on 27.07.2023.
//

import Foundation
import OpenAISwift

final class ChatBotViewModel {
    init() {}
    
    private var client: OpenAISwift?
    private var config: OpenAISwift.Config = OpenAISwift.Config.makeDefaultOpenAI(apiKey: Constants.API_KEY)
    
    
    
    func setup() {
        config = OpenAISwift.Config.makeDefaultOpenAI(apiKey: Constants.API_KEY)
        client = OpenAISwift(config: config)
    }
    
    func request(converstaion: String, completion: @escaping(String) -> Void) {
        client?.sendCompletion(with: converstaion, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? "hata var"
                completion(converstaion)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
