module Socky
  class WebSocket < ::Rack::WebSocket::Application

    DEFAULT_OPTIONS = {
      :debug => false
    }
    
    # Called when connection is opened
    def on_open
      @connection = Socky::Connection.new(self)
      send_data @connection.initialization_status
    end
    
    # Called when message is received
    def on_message(msg)
      puts "message received: " + msg
    end
    
    # Called when client closes clonnecton
    def on_close
      @connection.destroy if @connection
    end
    
    # Rack end
    def env
      @env
    end
    
    # Send JSON-encoded data instead of clear text
    def send_data(data)
      jsonified_data = data.to_json
      puts 'Sending: ' + jsonified_data
      super(jsonified_data)
    end
  end
end