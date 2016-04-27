require 'sinatra'
require 'uri'
require 'active_record'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///mylinks')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Video < ActiveRecord::Base
  has_many :comments
  validates_presence_of :link
end

class Comment < ActiveRecord::Base
  belongs_to :video
  validates_presence_of :body
  validates_presence_of :video_id
end

get '/' do
  @links = Video.order("id DESC")
  @comments = Comment.order("id")
  erb :index
end

get '/create' do
  erb :create
end

get '/about' do
  erb :about
end

post '/create' do
  link = Video.new(params[:link])
  if link.save
    redirect to "/"
  else
    erb :error
  end
end

get '/comment/:id' do
  erb :comment, :locals => { :video_id => params[:id] }
end

get '/item/:id' do
  erb :item, :locals => { :video_id => params[:id], :link => Video.find(params[:id]) }
end

get '/delete/:id' do
  Video.find(params[:id]).delete
  redirect to "/"
end

post '/comment' do
  comment = Comment.new(params[:comment])
  if comment.save
    redirect to "/"
  else
    return "failure!"
  end
end
