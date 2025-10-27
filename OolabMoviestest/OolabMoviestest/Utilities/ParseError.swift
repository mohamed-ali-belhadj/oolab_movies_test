//
//  ParseError.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 28/10/2025.
//

import Foundation

enum ParseError: Error {
    case invalidRoot
    case missing(String)
    case invalidType(String)
}
