require 'sinatra'
require 'sinatra/reloader'

get '/' do
  redirect '/memos'
end

before do
  memo_struct = Struct.new('Memo', 'id', 'title', 'content')
  memo = memo_struct.new('1', 'メモ', 'メモです')
  @memos = [memo_struct.new('1', 'メモ', 'メモです'),
            memo_struct.new('2', 'memo', 'this is memo')
  ]
end

get '/memos' do
  @title = 'メモアプリ一覧'
  erb :memos
end

get '/memos/new' do
  @title = '新規作成'
  erb :new_memo
end
