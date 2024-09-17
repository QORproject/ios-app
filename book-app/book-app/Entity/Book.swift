//
//  Book.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/15.
//

import Foundation

struct Book: Sendable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var auther: String
    var releaseDate: Date
}

extension Book {
    static func stub() -> Self {
        .init(name: "hoge", auther: "huga", releaseDate: .init())
    }
}
