module GnipApi
  class Search
    attr_accessor :url,:connection,:options,:response
    
    # @url https://search.gnip.com/accounts/ACCOUNT_NAME/search/prod.json
    
    # 
    def initialize(url)
      @url = URI.parse(url)
      get_connection
    end
    # @options {:query=>"rule or search string",:publisher=>"twitter"}
    def search(options={})
      @options = options
      @response = @connection.post(@url.path,MultiJson.dump(options))
      handle_response(@response)
    end

    def handle_response(response)
      raise_errors(@response)
      response
    end

      def raise_errors(response)
        code = response.status.to_i
        case code
        when 400
          raise GnipApi::General.new("Parameter check failed. This error indicates that a required parameter is missing or a parameter has a value that is out of bounds.")
        when 401
          raise GnipApi::Unauthorized.new
        when 404
          raise GnipApi::NotFound.new
        when 500
          raise GnipyApi::InformGnip.new
        when 503
          raise TopsyApi::Unavailable.new
        end
      end

    def parse_response
      MultiJson.load(@response.body) unless @response.body.strip.empty?
    end

    private
    
    def get_connection
      
      @connection = Faraday.new(:url => 'https://search.gnip.com/') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger               # log requests to STDOUT
        faraday.adapter  :typhoeus # make requests with Net::HTTP
        faraday.basic_auth GnipApi.configuration.user_name,GnipApi.configuration.password
      end
      
    end
  end
end