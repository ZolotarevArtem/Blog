require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "digest/md5"
require "./helpers.rb"
Dir.glob('./models/*.rb') do |rb_file|
  require "#{rb_file}"
end

set :database, "sqlite3:///db/blog.sqlite3"
set :sessions, true
 

#require posting.rb(helpers)
#helpers Posting
#jamail file

get "/" do
  @title = "Блог"
  @posts = Post.order("created_at DESC")
  erb :"posts/index"
end

#Posts
get "/posts/new" do
  @title = "Новый пост"
  @post = Post.new
  erb :"posts/new"
end

post "/posts" do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}"
  else
    erb :"posts/new"
  end
end

get "/posts/:id" do
  @post = Post.find(params[:id])
  @user = User.find_by(id: @post.user_id)
  @comment_show = Comment.where("post_id = ?", params[:id])
  @comment = Comment.new
  @title = @post.title  
  erb :"posts/show"
end

post "/posts/:id/comment" do
  @comment = Comment.new(params[:comment])
  @comment.save #проверить
  redirect "posts/#{@comment.post_id}"
end

get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  if session[:user][:id] == @post.user_id
    @title = "Edit Form"
    @post = Post.find(params[:id])    
    erb :"posts/edit"
  else
    403 #befo 
  end
end

put "/posts/:id" do
  @post = Post.find(params[:id])
  if session[:user][:id] == @post.user_id
    if @post.update_attributes(params[:post])
      redirect "/posts/#{@post.id}"
    else
      erb :"posts/edit"
    end
  else
    403
  end
end

delete "/posts/:id" do
  @post = Post.find(params[:id])
  if session[:user][:id] == @post.user_id
    @post.destroy
    redirect "/"
  else
    403
  end
end

#USER
get "/register" do
  @title = "Регистрация"
  @user = User.new
  erb :"/register" 
end

post "/register" do
=begin
  flash[:register] = nil 
  
  flash[:register] = "Пароль должен содержать не мение 6 символов" if @user.password.length < 6
  flash[:register] = "Пользователь с таким именем уже существует" if User.find_by(username: @user.username)
  flash[:register] = "Логин должен содержать не мение 3 символов" if @user.username.length < 3
  if (flash[:register] == nil && @user.save) #не работает!!!!
    redirect "/"
  else
    flash[:register] = "Что-то пошло не так. Повторите попытку позже." if flash[:register] == nil
    redirect "/register"
  end
=end
  @user = User.new(params[:user])
  if @user.save
    redirect "/"
  else
    redirect "/register"
  end
end

get "/login" do
  @title = "Вход"
  @user = User.new
  erb :"/login"
end

post "/login" do  
  @user = User.find_by_username(params[:user][:username])
  if @user && @user.password == params[:user][:password] #Digest::MD5.hexdigest
    session[:user] = @user
    redirect "/"  
  else 
    flash[:login] = "Вы ввели неверное имя пользователя или пароль"
    redirect "/login"
  end
end

get "/profile" do
  @title = "Личный кабинет"
  erb :"/profile" 
end

get "/logout" do
  session[:user] = nil
  redirect "/"
end

#ERRORS
not_found do
  @title = "404 Not Found"
  erb :"/404"
end

error 403 do
  @title = "403 Forbidden"
  erb :"/403"  
end
