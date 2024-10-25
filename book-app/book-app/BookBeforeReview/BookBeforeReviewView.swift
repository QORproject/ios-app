//
//  BookBeforeReviewView.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/10/11.
//

import SwiftUI


struct BookBeforeReviewView: View {
    enum FetchingState {
        case initial
        case loading
        case finished
    }

    let book: Book

    @Environment(\.dismiss) var dismiss
    @State private var beforeReview = ""
    @State private var isShowShortDescription = true
    @State private var fetcheingState: FetchingState = .initial

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
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $beforeReview)
                            .padding(.horizontal, -4)
                            .frame(minHeight: 150)
                        if beforeReview.isEmpty {
                            Text("なぜこの本を読むのか, 何を達成したいのか")
                                .foregroundColor(Color(uiColor: .placeholderText))
                                .padding(.vertical, 8)
                                .allowsHitTesting(false)
                        }
                    }
                }
                .padding(.top, 12)

                Divider().frame(maxWidth: .infinity, maxHeight: 1)

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 12) {
                        Text("🤖 AIによる分析")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.bottom, 6)
                        Button(action: {
                            Task.detached {
                                fetcheingState = .loading
                                sleep(3)
                                fetcheingState = .finished
                            }
                        }) {
                            Image(systemName: "goforward")
                        }
                    }

                    switch fetcheingState {
                    case .initial:
                        Text("AIに分析してもらいましょう...")
                    case .loading:
                        ProgressView()
                    case .finished:
                        HStack(spacing: 6) {
                            tag(title: "成長したい")
                            tag(title: "技術的")
                            tag(title: "調和")
                            tag(title: "貢献")
                        }
                        .padding(.top, 6)
                        HStack(spacing: 6) {
                            tag(title: "チームワーク")
                            tag(title: "向上心")
                        }
                        .padding(.top, 6)
                    }
                }
                .padding(.top, 12)
            }
        }
        .padding()
        .navigationBarItems(trailing: saveButton())
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
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

    private func saveButton() -> some View {
        Button(action: {
            dismiss()
        }) {
            Text("保存")
        }
    }
}

#Preview {
    BookBeforeReviewView(book: .stub())
}


extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
