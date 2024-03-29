# Sinatra-Memo
## Sinatraを使ったシンプルなメモアプリ
フィヨルドブートキャンプのプラクティス「[Sinatra を使ってWebアプリケーションの基本を理解する](https://bootcamp.fjord.jp/practices/157)
」の課題で作成したメモアプリになります。

## Rubyのバージョン
`3.0.4`

## インストール
`git clone`コマンドでリポジトリをインストールしてください。
```shell
git clone https://github.com/wata00913/Sinatra-Memo.git
```

Bundlerを使って、アプリケーションの起動に必要なgemをインストールします。
```shell
bundle install
```

## アプリケーションの起動
ローカルのみで起動可能です。

カレントディレクトリをSinatra-Memoのルートディレクトリにします。
bundle execコマンドを使ってアプリケーションを起動します。
```shell
bundle exec ruby app.rb
```

以下のURLにアクセスします。
```shell
http:localhost:4567/
```

後述の設定ファイルにて、メモアプリに関する設定ができますが、インストール時の設定でも動作します。

## 設定ファイル
メモアプリに関する設定ができます。`config.json`ファイルで設定を行います。
| 設定項目           | キー           | 概要                                                 |
|--------------------|----------------|------------------------------------------------------|
| データの保存形式   | save_type      | データの保存形式を指定します。                       |
| JSONファイルのパス | json_data_path | JSON形式でのデータ保存用のファイルパスを指定します。 |

### データの保存形式
データの保存形式を指定します。設定項目が無い場合は、`json_data/data.json`をデータ保存に用います。
| 形式名 | 概要           |
|--------|----------------|
| json   | JSONファイルで保存します。</br> 設定`JSONファイルのパス`で任意の場所に保存データを指定することも可能です。|
| db     | DBで保存します。DBにはPostgreSQLを使います。 |

現在、DB形式は未対応です。

### JSONファイルのパス
JSONファイルの保存場所を指定します。相対パス、絶対パスのどちらでも指定可能です。</br>

個人で用意したJSONファイルは、空の状態だとアプリケーションの起動に失敗します。
以下のように設定してください。
```json
[]
```

### `config.json`の設定例
```json
{
    "json_data_path": "./json_data/data.json",
    "save_type": "json"
}
```

## URL
| URL             | method | description                   |
|-----------------|--------|-------------------------------|
| /               | GET    | /memosにリダイレクトする      |
| /memos          | GET    | 一覧画面を表示する            |
| /memos          | POST   | :idのメモを新規作成する       |
| /memos/new      | GET    | 新規作成画面を表示する        |
| /memos/:id      | GET    | :idのメモの詳細画面を表示する |
| /memos/:id      | PATCH  | :idのメモの内容を更新する     |
| /memos/:id      | DELETE | :idのメモのを削除する         |
| /memos/:id/edit | GET    | :idのメモの編集画面を表示する |
