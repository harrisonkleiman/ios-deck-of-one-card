//
//  CradControllerViewController.swift
//  DeckOfOneCard
//
//  Created by Harrison Kleiman on 5/18/22.
//

import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        
        // MARK: - 1: PREPARE URL
        guard let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/") else { return completion(.failure(.invalidURL)) }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let countItem = URLQueryItem(name: "count", value: "1")
        components?.queryItems = [countItem]
        guard let finalURL = components?.url else { return (completion(.failure(.invalidURL))) }
        
        // MARK: - 2: CONTACT SERVER
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            // MARK: - 3: HANDLE ERRORS FROM SERVER
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            // MARK: - 4: CHECK FOR JSON DATA
            guard let data = data else { return completion(.failure(.noData)) }
            
            // MARK: - 5: DECODE JSON INTO A CARD
            do {
                let topLevel = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevel.cards.first else { return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
        
    // @escaping MEANS THE CLOSURE CAN RUN AFTER YTHE FUNCTION RETURNS. PERFECT FOR CONCURRENCY/MULTI-THREADING
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
        // 1 - URL
        let url = card.image
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            // 3 - Error handling
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - "Decode" an image
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
            
        }.resume()
    }
}
