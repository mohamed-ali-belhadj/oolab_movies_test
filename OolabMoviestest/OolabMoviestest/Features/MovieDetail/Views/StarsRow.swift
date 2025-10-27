//
//  StarsRow.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 28/10/2025.
//

import Foundation
import SwiftUI

struct StarsRow: View {
    let filled: Int
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<5) { i in
                Image(systemName: i < filled ? "star.fill" : "star")
                    .imageScale(.small)
            }
        }
    }
}
