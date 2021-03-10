module Exceptions
  class NotFound < StandardError
    def http_status
      404
    end
  
    def code
      'not_found'
    end
  
    def detail
      "A resource could not be found for that search term. Try again."
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
