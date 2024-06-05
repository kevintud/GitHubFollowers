//
//  ErrMessages.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/18/24.
//

import Foundation
enum ErrMessages: String, Error {
    case invalidUsername = "This username create and invalid request. Please try again."
    case unableToComplete = " Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was error in this user"
    case alreadyInFavorites = "You already add this to you favorite."
}
