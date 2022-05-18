//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Harrison Kleiman on 5/18/22.
//

import UIKit

class CardViewController: UIViewController {

    // MARK: - OUTLETS
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        // REQUEST CARD FROM CardController
        CardController.fetchCard { [weak self] (result) in
            
            // RETURN TO MAIN THREAD AFTER A FETCH
            DispatchQueue.main.async {
                
                // SWITCH ON "RESULT" TO HANDLE BOTH POSSIBILITIES
                switch result {
                    
                    // IF SUCCESS, FETCH IMAGE
                case.success(let card):
                    self?.fetchImageAndUpdateView(with: card)
                    
                    // IF FAILURE, LET USER KNOW
                case.failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
     }
    
    // MARK: - METHODS
    
    func fetchImageAndUpdateView(with card: Card) {
        
        // REQUEST AN IMAGE FROM THE CardController
        CardController.fetchImage(for: card) { [weak self] (result) in
            
            // RETURN TO MAIN THREAD AFTER A FETCH
            DispatchQueue.main.async {
                
                // SWITCH ON "RESULT" TO HANDLE BOTH POSSIBILITIES
                switch result {
                
                    // IF SUCCESS, WE HAVE EVERYTHING NEEDED TO UPDATE UI
                case .success(let image):
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImageView.image = image
                    
                    // IF FAILURE, LET USER KNOW
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
