module PantauAuthWrapper
  module AuthMethods
    attr_accessor :the_access_token

    def protected_endpoint=(protected)
      @protected_endpoint = protected
    end

    def protected_endpoint?
      @protected_endpoint || false
    end

    def the_access_token
      @_the_access_token
    end

    def the_access_token=(token)
      @_the_access_token = token
    end

  end
end