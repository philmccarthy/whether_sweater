class BackgroundsFacade
  class << self
    def get_background(location)
      Image.new(BackgroundsService.call_background(location))
    end
  end
end
