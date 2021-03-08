module Exceptions
  class BadAddress < StandardError
    def http_status
      400
    end
  
    def code
      'bad_address'
    end
  
    def detail
      "Are you sure that's a valid location? We couldn't find it!"
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
