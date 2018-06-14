require 'sinatra'

srv_bind = "0.0.0.0"
srv_port = 80
if `uname -s` =~ /Darwin/
  srv_port = 8081
end

set :port, srv_port
set :bind, srv_bind

get '/hello' do
  "hello"
end
get '/hello2' do
  "hello2"
end
get '/eh' do
  locals = {
    vals: [ 'w', 'f', 'f' ]
  }
  erb :eh, :locals => locals
end
get '/' do
  File.read(File.join('static', 'index.html'))
end
