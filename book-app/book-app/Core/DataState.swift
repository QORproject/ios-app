//
//  DataState.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/16.
//

// 参考: https://zenn.dev/kntk/articles/d1090ada19d3f5
// enumを用いて、APIリクエストする画面の状態を管理する
// 共通化できる！というわけではなく、あくまで提案として実装

/// API,DB に接続しデータを取得するプロパティに対して、ローディング状態を管理可能にする
enum DataState<V, E: Error> {
    case idle

    case initialLoading
    ///success の状態でリロードする際、画面にデータを表示させ続ける
    case reLoading(V)   // BookListViewはpullToRefreshでデータ更新あり得るので実装, success->initalLoading->success のinitalLoading中にもデータを表示させ続ける
    ///failure の状態でリロードする際、画面にエラーを表示させ続ける
    case retryLoading(E)   // リロード時のエラーを表現するため, failure->initalLoading->success のinitalLoading中にエラーを表示させ続ける

    case success(V)
    case failure(E)
}


extension DataState {
    /// loading中に データ(取得成功したデータ,エラー)を表示し続ける
    mutating func startLoading() {
        switch self {
        case .idle:
            self = .initialLoading
        case .success(let value):
            self = .reLoading(value)
        // failureからロードするときはretryLoadingへ
        case .failure(let error):
            self = .retryLoading(error)
        case .initialLoading, .reLoading(_), .retryLoading(_):
            break
        }
    }

    /// ローディングが複数回行われる場合、初期ローディングか判定できたら便利
    var isInitialLoading: Bool {
        if case .initialLoading = self {
            return true
        }
        return false
    }

    var isLoading: Bool {
        switch self {
        case .initialLoading,
                .reLoading,
                .retryLoading:
            return true

        default:
            return false
        }
    }
}
