//
//  DateParser.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation
enum DateParser {
    static func parseAPIDate(_ string: String) -> Date? {
        let explicit = DateFormatter()
        explicit.calendar = Calendar(identifier: .iso8601)
        explicit.locale = Locale(identifier: "en_US_POSIX")
        explicit.timeZone = TimeZone(secondsFromGMT: 0)
        explicit.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let d = explicit.date(from: string) { return d }

        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return iso.date(from: string)
    }

    static func yearString(from date: Date?) -> String {
        guard let date else { return "—" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
}
