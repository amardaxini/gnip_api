module GnipApi
  class Configuration
    attr_accessor :user_name,:password
    def initialize(user_name=nil,password=nil)
      @user_name = user_name
      @password = password
      
    end
  end
  class << self
    attr_accessor :configuration
  end
  def self.configure
    self.configuration = Configuration.new
    yield(configuration) if block_given?
  end
end  