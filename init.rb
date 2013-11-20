require 'sinatra'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/base.db') #подключение и путь к бд
DataMapper.finalize #Проверка моделей
DataMapper.auto_upgrade!  #Создает новые таблицы и добавляет новые столбцы в существующие таблицы

get '/posts' do #роутинг для ссылки /posts
  #<hh user=posts> = Post.all #задаем переменную <hh user=posts> равную выводу всех значений бд из модели Post
  erb :'index' #выводим все в шаблоне index.erb*
end

class Post
  include DataMapper::Resource
  property :id, Serial #Идентификатор
  property :title, String #String указывает на то, что поле title будет иметь тип "Строка" и стандартно не более 50 символов
  property :body, Text #Text указывает на то, что поле body будет иметь тип "Текст" размером 65535 символов
end

#Create new Post
get '/posts/new' do #роутинг для ссылки создания страницы
  erb :'posts/new' #рендерим шаблон /posts/new.erb
end

post '/posts/new' do
  params.delete 'submit'
  #<hh user=post> = Post.create(params) #сохраняем данные, полученные из формы в базу данных модели Post
  redirect '/posts' #редиректимся на страницу со всеми постами
end
