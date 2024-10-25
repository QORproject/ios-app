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
    var imageName: String
    var auther: String
    var releaseDate: String
    var description: String
    var shortDescription: String {
        if self.description.count >= 100 {
            return "\(description.prefix(100))"
        } else {
            return description
        }
    }
    var hasShortDescription: Bool {
        if self.description.count >= 100 {
            return true
        } else {
            return false
        }
    }
    var beforeReview: String
}

extension Book {
    static func stub() -> Self {
        .init(name: "伝え方が9割", imageName: "book02", auther: "佐々木 圭一", releaseDate: "20xx/xx/xx", description: "    この本は、著者が膨大な時間とトライ&エラーで導き出した方法論を整理しました。料理のレシピのように、誰でもコトバをつくれるよう体系化してあります。誰でも自分の日常から、試行錯誤の上で伝え方の技術を身につけることもできますが、それだと辿り着くまでに十数年かかってしまいます。効率がよくありません。この本は、著者のように回り道をしなくても魅力的なコトバを最短でつくれるよう構成してあります。", beforeReview: "相手に伝わりやすい表現やコミュニケーションの工夫を学び、日常の対話やビジネスシーンで効果的な伝達力を向上させたい！")
    }
}
