require 'sinatra'
require 'sinatra/reloader' if development?

enable :sessions

class User
  attr_accessor :first_name, :last_name, :age

  def initialize(last_name, first_name, age)
    self.last_name = last_name
    self.first_name = first_name
    self.age = age
  end

  def name
    last_name + ' ' + first_name
  end
end

get '/' do
  'Hello world!'
end

get '/now' do
  Time.now.to_s
end

get '/page' do
  @title = 'CODEBASE'
  @now = Time.now
  erb :page
end

get '/hello/:name' do
   "Hello #{params['name']}!"
end

get '/search' do
  params[:q]
end

get '/form' do
  # form を表示する
  erb :form_input
end

post '/form' do
  @name = params[:name]
  @email = params[:email]
  @content = params[:content]
  # formの中身を表示する
  erb :form_output
end

get '/upload' do
  erb :input_image
end

post '/upload' do
  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("./public/images/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end

  erb :show_image
end

get '/top' do
  erb :top, layout: :app
end

get '/about' do
  erb :about, layout: :app
end

get '/school' do
  erb :school, layout: :app
end

get '/form_session' do
  erb :form_input_session
end

post '/form_session' do
  session[:name] = params[:name]
  session[:email] = params[:email]
  session[:content] = params[:content]

  redirect '/form_session'
end

get '/users' do
  user1 = { 'last_name' => 'Tachibana', 'first_name' => 'Yutaka', 'age' => 30 }
  user2 = { 'last_name' => 'Nakatsukasa', 'first_name' => 'Yuya', 'age' => 28 }
  user3 = { 'last_name' => 'Suzuki', 'first_name' => 'Takayuki', 'age' => 28 }
  user4 = { 'last_name' => 'Teraji', 'first_name' => 'Takashi', 'age' => 32 }
  user5 = { 'last_name' => 'Tamaki', 'first_name' => 'Ko', 'age' => 22 }
  @users = [user1, user2, user3, user4, user5]

  @users = db.query('SELECT * FROM users').to_a = db.query('SELECT * FROM users').to_a

  erb :users, layout: :app
end
