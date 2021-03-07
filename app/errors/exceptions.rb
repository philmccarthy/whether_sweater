module Exceptions
  class InvalidParams < StandardError
    def http_status
      400
    end
  
    def code
      'invalid_parameters'
    end
  
    def message
      'Parameters were invalid. Please review the documentation for this endpoint.'
    end
  
    def to_hash
      {
        message: message,
        errors: [
          code
        ]
      }
    end
  end
end
