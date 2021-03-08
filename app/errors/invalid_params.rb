module Exceptions
  class InvalidParams < StandardError
    def http_status
      400
    end
  
    def code
      'invalid_parameters'
    end
  
    def detail
      'Parameters were invalid. Please review the documentation for this endpoint.'
    end
  
    def to_hash
      {
        errors: [
          {
            code: code,
            detail: detail
          }
        ]
      }
    end
  end
end
