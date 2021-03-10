class BackgroundsFacade
  class << self
    def get_background(location)
      image = BackgroundsService.call_background(location)
      raise Exceptions::NotFound if image[:total_results].zero?
      Image.new(image)
    end
  end
end
