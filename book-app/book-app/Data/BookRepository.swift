//
//  BookRepository.swift.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/15.
//

import Foundation

// テストではStubを定義して、UseCaseへDIする
protocol BookRepository {
    // C: Create
    func add(book: Book) async throws -> Result<Void, HTTPError>
    // R: Read
    func fetchBookDetail(bookID: UUID) async throws -> Result<Book, HTTPError>
    func fetchBooks() async throws -> Result<[Book], HTTPError>
    // U: Update
    func update(book: Book) async throws -> Result<Void, HTTPError>
    // D: Delete
    func delete(bookID: UUID) async throws -> Result<Void, HTTPError>
}

final class BookRepositoryImpl: BookRepository {
    func add(book: Book) async throws -> Result<Void, HTTPError> {
        return .success(())
    }
    
    func fetchBookDetail(bookID: UUID) async throws -> Result<Book, HTTPError> {
        return .success(.stub())
    }
    
    func fetchBooks() async throws -> Result<[Book], HTTPError> {
        let books: [Book] = [.stub(), .stub(), .stub()]
        return .success(books)
    }
    
    func update(book: Book) async throws -> Result<Void, HTTPError> {
        return .success(())
    }
    
    func delete(bookID: UUID) async throws -> Result<Void, HTTPError> {
        .success(())
    }
    
}
