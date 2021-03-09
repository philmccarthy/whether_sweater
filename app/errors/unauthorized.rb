module Exceptions
  class Unauthorized < StandardError
    def http_status
      401
    end
  
    def code
      'unauthorized'
    end
  
    def detail
      'Unauthorized. Please confirm your credentials and try again.'
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
