//
//  BookListViewModel.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/15.
//

import Foundation

// MARK: - protocols

// kickstarter(https://github.dev/kickstarter/ios-oss) を参考に
// Input(ビジネスロジックを分けるので今回はaction),Output,Type をprotocolとして定義
// kickstarter実装例: UpdateDraftViewModel.swift

// https://qiita.com/muukii/items/045b12405f7acff1a9fd

/// ユーザーアクションに合わせてメソッドを定義する
///Why ビジネスロジックを定義しない: Viewの責務は ユーザーアクション+データ表示 のみであるから。ビジネスロジックをこのプロトコルで表現せず、UseCaseのプロトコルで表現する。
protocol BookListViewModelAction {
    func bookOnDelete(bookID: UUID) async
    func createButtonTapped()
    func taskTapped()
}

protocol BookListViewModelOutput {
    // TODO: - DataState使うとデータへアクセスできない
    // APIからデータを取得する場合はDataStateでラップして、ローディング状況でのデータ表示を柔軟にする
    var booksState: DataState<[Book], HTTPError> { get }
}

/// inputs, outputsしか定義されていないので、VMへのアクセス時には必ず (Viewからの) 入力なのか出力なのかを制限できる → 実装者によるブレを減らせる
protocol BookListViewModelProtocol: BookListViewModelAction, BookListViewModelOutput {
    var action: BookListViewModelAction { get }
    var output: BookListViewModelOutput { get }
}

// MARK: - ViewModel

final class BookListViewModel: BookListViewModelProtocol {
    var action: BookListViewModelAction { self }
    var output: BookListViewModelOutput { self }

    var booksState: DataState<[Book], HTTPError> = .idle

    let usecase: BookListUseCase
    init(usecase: BookListUseCase) {
        self.usecase = usecase
    }

    func bookOnDelete(bookID: UUID) async {
        booksState = await usecase.delete(bookID: bookID)
    }

    func createButtonTapped() {
        // [画面遷移] Book追加画面
    }
    
    func taskTapped() {
        // [画面遷移] Book編集画面
    }
}


