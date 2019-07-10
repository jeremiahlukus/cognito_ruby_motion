class ApiClient
  class << self
    def client
#      @client ||= AFMotion::SessionClient.build("http://localhost:3000") do
      @client ||= AFMotion::SessionClient.build("https://9jwg3hy0ce.execute-api.us-east-1.amazonaws.com/dev") do
        request_serializer :json
        response_serializer :json
        header "Content-Type", "application/json"
      end
    end

    def load_response
      client.get('/hello') do |result|
        $r = result
        result.object
      end
    end

    def update_authorization_header(headers_hash)
      mp "updating auth headers"
      headers_hash.each do |key, value|
        puts value
        client.headers[key] = value
      end
    end

  end
end
