//
//  ErrorMessages.swift
//  GithubDemo
//
//  Created by Sagar on 18/12/25.
//

import Foundation

enum SSError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Please try again.!"
}
