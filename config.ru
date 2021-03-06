# Start with:
# $ thin -R socky.ru start
current_dir = File.expand_path(File.dirname(__FILE__))
require current_dir + '/lib/socky/server'

options = {
  :config_file => current_dir + '/example/config.yml',
  :debug => true
}

map '/websocket' do
  run Socky::Server::WebSocket.new options
end

map '/http' do
  use Rack::CommonLogger
  
  run Socky::Server::HTTP.new options
end