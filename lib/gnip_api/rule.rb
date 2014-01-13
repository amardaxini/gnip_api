module GnipApi
  class Rule
    attr_accessor :rules,:url,:connection,:response
    # @url https://api.gnip.com/accounts/<account>/publishers/<publisher>/streams/<stream>/<label>/rules.json

    
    def initialize(url)
      @url = URI.parse(url)
      @rules = []
      get_connection
    end

    def build_rule(rule,tag=nil)
      @rules << {"value"=>rule,"tag"=>tag}
    end

    def add_rules
      @response = @connection.post(@url.path,MultiJson.dump(build_rule_options))
      handle_response(@response)
    end

    def delete_rules
     @response = 
      @connection.delete do |req|
        req.url @url.path
        req.headers['Content-Type'] = 'application/json'
        req.body = MultiJson.dump(build_delete_rules)
      end
     
      handle_response(@response)
    end
    def show_rules
      @response = @connection.get(@url.path)
      handle_response(@response)
    end

    def build_rule_options
      {"rules"=>@rules.flatten.uniq.compact}  
    end

    def build_delete_rules
      {"rules"=>Array(@rules).collect{|rule| {"value"=>rule["value"]}}}
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
        raise GnipApi::InformGnip.new
      when 503
        raise GnipApi::Unavailable.new
      end
    end

    def parse_response
      MultiJson.load(@response.body) unless @response.body.strip.empty?
    end
    private
    
    def get_connection
      
      @connection = Faraday.new(:url => 'https://api.gnip.com/') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger               # log requests to STDOUT
        faraday.adapter  :typhoeus # make requests with Net::HTTP
        faraday.basic_auth GnipApi.configuration.user_name,GnipApi.configuration.password
      end
      
    end
  end
end