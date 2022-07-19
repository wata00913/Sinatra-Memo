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

helpers do
  def use_result_session_if
    return unless session[:result]

    result = session[:result]
    # 現状はメッセージの設定のみ
    @message = result.msg
    # メッセージを反映後、受け渡したデータは削除する。
    session.delete(:result)
  end
end

get '/memos' do
  @title = 'メモアプリ一覧'
  # POSTメソッドでリダイレクトした場合、セッションを利用する
  use_result_session_if

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

  # PATCHメソッドでリダイレクトした場合、セッションを利用する
  use_result_session_if

  result = @service.find_by(id)

  if result.success?
    @memo = result.data
    erb :detail_memo
  else
    status 404
  end
end

get '/memos/:id/edit' do |id|
  @title = '編集'

  result = @service.find_by(id)
  if result.success?
    @memo = result.data
    erb :edit_memo
  else
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
