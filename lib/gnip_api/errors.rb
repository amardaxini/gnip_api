module GnipApi
  class GnipError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super
    end
  end

  class RateLimitExceeded < StandardError; end
  class Unauthorized      < StandardError; end
  class General           < GnipError; end
  class InformGnip < StandardError; end
  class Unavailable   < StandardError; end
  class NotFound      < StandardError; end
end