//
//  BookDetailView.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/16.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book

    @State private var isShowShortDescription = true

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .top, spacing: 12) {
                    Image(book.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 336/3, height: 482/3)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(book.name)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        Text(book.auther)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(.gray)
                        Text("発売 : \(book.releaseDate)")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(.gray)

                        if isShowShortDescription {
                            Text("\(book.shortDescription)")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundStyle(.gray)
                                .padding(.top, 12)
                            if book.hasShortDescription {
                                Button(action: {
                                    isShowShortDescription = false
                                }) {
                                    Text("もっと見る")
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                        .foregroundStyle(.blue)
                                        .padding(.top, -2)
                                }
                            }
                        } else {
                            Text("\(book.description)")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundStyle(.gray)
                                .padding(.top, 12)
                            Button(action: {
                                isShowShortDescription = true
                            }) {
                                Text("閉じる")
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundStyle(.blue)
                                    .padding(.top, -2)
                            }
                        }
                    }
                }

                Divider().frame(maxWidth: .infinity, maxHeight: 1)

                VStack(alignment: .leading, spacing: 6) {
                    Text("📝 前レビュー")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Text(book.beforeReview)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                }
                .padding(.top, 12)

                Divider().frame(maxWidth: .infinity, maxHeight: 1)

                VStack(alignment: .leading, spacing: 6) {
                    Text("🤖 AIによる分析")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .padding(.bottom, 6)
                    HStack(spacing: 6) {
                        tag(title: "成長したい")
                        tag(title: "技術的")
                        tag(title: "調和")
                        tag(title: "貢献")
                    }
                    HStack(spacing: 6) {
                        tag(title: "チームワーク")
                        tag(title: "向上心")
                    }
                }
                .padding(.top, 12)
            }
        }
        .padding()
    }

    private func tag(title: String) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .padding(12)
            .padding(.horizontal, 6)
            .background(
                Color.orange.opacity(0.3).clipShape(RoundedRectangle(cornerRadius: 25))
            )
    }
}

#Preview {
    BookDetailView(book: .stub())
}

