//
//  Persistence<amager.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 2/5/24.
//

import Foundation

enum PersistenceActionType{
    case add, remove
}
enum PersistenceManager {
    static private let defualts = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith (favorite: Follower, actionType: PersistenceActionType, completed: @escaping(ErrMessages?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType{
                case .add:
                    
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        
                        return
                    }
                    
                    retrievedFavorites.append(favorite)

                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorite: retrievedFavorites))
            case .failure(let error):
                completed(error)
            }
        }
    }

    
    static func retrieveFavorites(complete: @escaping (Result<[Follower], ErrMessages>) -> Void) {
        guard let favoritesData = defualts.object(forKey: Keys.favorites) as? Data else {
            complete(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            complete(.success(favorites))
        } catch {
            complete(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorite: [Follower]) -> ErrMessages? {
        
        do {
            let encoder = JSONEncoder()
            let encodingFavorite = try encoder.encode(favorite)
            defualts.setValue(encodingFavorite, forKey: Keys.favorites)
            
            return nil
            
        }catch {
            return .unableToFavorite
        }
    }
}
