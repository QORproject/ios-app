//
//  BookListUseCase.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/16.
//

import Foundation

// ビジネスロジックを Usecase(protocol) + Impl で分ける。
// テストでビジネスロジックをDIしやすくなる。
// UseCase APIからのレスポンスに対して success or failure を判定する
// VMには ProcessState に合わせた success or failure を(UseCaseで作成し)返す

protocol BookListUseCase {
    func fetchBookDetail(selectedBook: Book) async -> DataState<Book, HTTPError>   // TODO: 検討, HTTPErrorを使うのはRepositoryまでにしておくのが良い？
    func fetchBooks() async -> DataState<[Book], HTTPError>
    func delete(bookID: UUID) async -> DataState<[Book], HTTPError>
}

struct BookListUseCaseImpl: BookListUseCase {
    let repository: BookRepository = BookRepositoryImpl()

    // fetch系は
    // Result<[Book](←JSON), HTTPError> -> DataState<[Book](←convertする必要がないので変化なし), HTTPError> へと変換し、VMへDataStateを渡す
    func fetchBookDetail(selectedBook: Book) async -> DataState<Book, HTTPError> {
        let bookID = selectedBook.id
        do {
            let result = try await repository.fetchBookDetail(bookID: bookID)
            switch result {
            case .success(let bookDetail):
                return .success(bookDetail)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(.unknownError)
        }
    }

    func fetchBooks() async -> DataState<[Book], HTTPError> {
        do {
            let result = try await repository.fetchBooks()
            switch result {
            case .success(let books):
                return .success(books)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(.unknownError)
        }
    }

    // TODO: 検討, deleteした後に Vで表示する books の状態を更新するのはどこの責務？ VM(booksをそのまま書き換える) or Usecase(fetchBooks()して[Book]をVMへ返し、VMで更新) → VMかなあ.結局や両者VMでbooksを書き換えているのに変わりはない
    func delete(bookID: UUID) async -> DataState<[Book], HTTPError> {
        do {
            let _ = try await repository.delete(bookID: bookID)
            let result = try await repository.fetchBooks()
            switch result {
            case .success(let books):
                return .success(books)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(.unknownError)
        }
    }
}
