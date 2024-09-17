//
//  BooksView.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/15.
//

import SwiftUI

struct BookListView: View {
    private let vm: BookListViewModelType = .init()

    private var books: [Book] = [.stub(), .stub(), .stub()]
    @State private var selectedBooks = Set<UUID>()

    var body: some View {
        NavigationView {
            List(books, selection: $selectedBooks) {
                Text("\($0.name)")
            }
            .navigationTitle("Todos")
            .toolbar { EditButton() }
            .onChange(of: selectedBooks) {
                print(selectedBooks)
            }
        }
    }
}

#Preview {
    BookListView()
}
