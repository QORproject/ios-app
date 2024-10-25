//
//  BooksView.swift
//  book-app
//
//  Created by 濵田　悠樹 on 2024/09/15.
//

import SwiftUI

struct BookListView: View {
    private let vm: BookListViewModelProtocol = BookListViewModel(usecase: BookListUseCaseImpl())

    private var books: [Book] = [
        .init(name: "伝え方が9割", imageName: "book02", auther: "佐々木 圭一", releaseDate: "20xx/xx/xx", description: "    この本は、著者が膨大な時間とトライ&エラーで導き出した方法論を整理しました。料理のレシピのように、誰でもコトバをつくれるよう体系化してあります。誰でも自分の日常から、試行錯誤の上で伝え方の技術を身につけることもできますが、それだと辿り着くまでに十数年かかってしまいます。効率がよくありません。この本は、著者のように回り道をしなくても魅力的なコトバを最短でつくれるよう構成してあります。", beforeReview: "相手に伝わりやすい表現やコミュニケーションの工夫を学び、日常の対話やビジネスシーンで効果的な伝達力を向上させたい！"),
        .init(name: "リーダブルコード", imageName: "book01", auther: "O'Reily", releaseDate: "20xx/xx/xx", description: "「美しいコードを見ると感動する。優れたコードは見た瞬間に何をしているかが伝わってくる。そういうコードは使うのが楽しいし、自分のコードもそうあるべきだと思わせてくれる。本書の目的は、君のコードを良くすることだ」(本書「はじめに」より)。コードは理解しやすくなければならない。本書はこの原則を日々のコーディングの様々な場面に当てはめる方法を紹介します。名前の付け方、コメントの書き方など表面上の改善について。コードを動かすための制御フロー、論理式、変数などループとロジックについて。", beforeReview: "可読性の高いコードを書く技術を習得することで、開発効率を上げ、チーム内でのコードの共有や保守性を向上させたい！"),
        .init(name: "完訳 7つの習慣 人格主義の回復", imageName: "book03", auther: "スティーブン", releaseDate: "20xx/xx/xx", description: "全世界4,000万部、国内240万部を超え、今も読み続けられるビジネス書のベストセラー『7つの習慣』は、人生哲学の定番として親しまれてきました。今回スティーブン・R・コヴィー博士没後1年を期に、『7つの習慣』が本来持つ「人格主義」に基づき、原書に忠実に訳し直しました。よりわかりやすく理解しやすい完全訳の『完訳 7つの習慣 人格主義の回復』。豊かな人生を望むすべての人にお届けします。", beforeReview: "自己成長とリーダーシップスキルを向上させ、仕事や人生におけるバランスを改善し、効果的な問題解決と成果を得るための考え方を学びたい！"),
        .init(name: "漫画 君たちはどう生きるか", imageName: "book04", auther: "吉野源三郎", releaseDate: "20xx/xx/xx", description: "1937年に出版されて以来、数多くの人に読み継がれてきた、吉野源三郎さんの名作「君たちはどう生きるか」。人間としてどう生きればいいのか、楽しく読んでいるうちに自然と考えるように書かれた本書は、子供はもちろん多くの大人たちにも共感をもって迎えられてきました。勇気、いじめ、貧困、格差、教養、、、昔も今も変わらない人生のテーマに真摯に向き合う主人公のコペル君と叔父さん。二人の姿勢には、生き方の指針となる言葉が数多く示されています。", beforeReview: "私は「君たちはどう生きるか」を読むことで、人間としての在り方や生き方について深く考える機会を得たいと思っています。本書は時代を超えて多くの人に共感されており、コペル君と叔父さんの対話を通じて、勇気や教養、社会的な問題に対する姿勢を学べます。人生の普遍的なテーマに向き合いながら、自分自身の生き方や価値観を見つめ直し、よりよい方向へと導いてくれる本だと感じています。"),
        .init(name: "新版　科学がつきとめた「運のいい人」", imageName: "book05", auther: "中野 信子", releaseDate: "20xx/xx/xx", description: "あなたも「運のいい人」になりませんか？日本・最注目の脳科学者がつきとめた、運のいい人だけがやっている「思考」と「行動」「自分は運が悪い」と思っていませんか？　でも「運」というものは必ずしも、その人がもともと持っていたり生まれつき決まっていたりするものではなく「その人の考え方と行動パターンによって変わる」のです。「運がいい人」は「運が良くなる」考え方や行動パターンを習慣づけているのです。それではどのようにしたら「運のいい人」になれるのか？　優秀な脳科学者である著者が科学的見地から、「運のいい」考え方や行動パターンを習慣づける方法を紹介していきます。", beforeReview: "この本を読むことで、運を良くするための思考や行動パターンを理解し、日常生活や仕事においてよりポジティブな結果を引き寄せたいと考えています。運は先天的なものだけではなく、考え方や行動で変化させられるという視点は非常に興味深く、脳科学的なアプローチを通じて、自分自身の成長と成功への道筋を科学的に学ぶことができる点に魅力を感じています。"),
    ]

    var body: some View {
        NavigationView {
            List(books, id: \.id) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    HStack(alignment: .top, spacing: 24) {
                        Image(book.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 336/3, height: 482/3)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(book.name)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text("発売日: \(book.releaseDate)")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .foregroundStyle(.gray)
                            Text(book.beforeReview)
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .padding(.top, 12)
                        }
                    }
                    .padding(.vertical, 12)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("本一覧")
            .navigationBarItems(trailing: plusButton())
        }
        .background(.white)
    }

    private func plusButton() -> some View {
        NavigationLink(destination: BookBeforeReviewView(book: .stub())) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    BookListView()
}
