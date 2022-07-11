require 'sinatra'
require 'sinatra/reloader'
require_relative './model/memo_service'

enable :sessions

get '/' do
  redirect '/memos'
end

before do
  @service = MemoService.new
  @message = ''
end

get '/memos' do
  @title = 'メモアプリ一覧'
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
  if session[:result]
    @message = session[:result][:msg]
    session.delete(:result)
  end
  @memo = @service.find_by(id)
  erb :detail_memo
end

get '/memos/:id/edit' do |id|
  @title = '編集'
  @memo = @service.find_by(id)
  erb :edit_memo
end

put '/memos/:id' do |id|
  session[:result] = @service.update(id, params[:title], params[:content])
  redirect "/memos/#{id}"
end

delete '/memos/:id' do |id|
  session[:result] = @service.delete(id)
  redirect '/memos'
end
