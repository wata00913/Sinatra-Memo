require 'sinatra'
require 'sinatra/reloader'
require_relative './model/memo_service'

enable :sessions
set :show_exceptions, :after_handler

get '/' do
  redirect '/memos'
end

before do
  @service = MemoService.new
  @message = ''
end

get '/memos' do
  @title = 'メモアプリ一覧'
  # リダイレクトで受け取ったメッセージを反映後、受け渡したデータは削除する。
  # TODO: セッションを用いた処理を共通化する
  if session[:result]
    @message = session[:result][:msg]
    session.delete(:result)
  end
  @memos = @service.memos
  erb :memos
end

post '/memos' do
  session[:result] = @service.create(params[:title], params[:content])
  redirect 'memos'
end

get '/memos/new' do
  @title = '新規作成'
  erb :new_memo
end

get '/memos/:id' do |id|
  @title = '詳細'
  # リダイレクトで受け取ったメッセージを反映後、受け渡したデータは削除する。
  if session[:result]
    @message = session[:result][:msg]
    session.delete(:result)
  end

  result = @service.find_by(id)

  case result[:result]
  when 'success'
    @memo = result[:data]
    erb :detail_memo
  when 'fail'
    status 404
  end
end

get '/memos/:id/edit' do |id|
  @title = '編集'

  result = @service.find_by(id)
  case result[:result]
  when 'success'
    @memo = result[:data]
    erb :edit_memo
  when 'fail'
    status 404
  end
end

not_found do
  erb :not_found
end

error 500 do
  erb :server_error
end

patch '/memos/:id' do |id|
  session[:result] = @service.update(id, params[:title], params[:content])
  redirect "/memos/#{id}"
end

delete '/memos/:id' do |id|
  session[:result] = @service.delete(id)
  redirect '/memos'
end
