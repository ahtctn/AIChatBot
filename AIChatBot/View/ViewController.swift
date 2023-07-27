//
//  ViewController.swift
//  AIChatBot
//
//  Created by Ahmet Ali ÇETİN on 27.07.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var models: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("başladı")
        for model in models {
            print(model.lowercased())
        }
        // Burada API Caller'ın setup fonksiyonunu çağırmayı unutmayın.
        APICaller.shared.setup()
    }
    
    @IBAction func sendTapped(_ sender: UIButton) {
        call()
        
    }
    
    private func call() {
        print("call")
        APICaller.shared.getResponse(input: "Merhaba, nasılsın") { [weak self] result in
            switch result {
            case .success(let output):
                self?.models.append(output)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
