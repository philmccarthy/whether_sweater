class ImageSerializer
  include JSONAPI::Serializer
  set_id { nil }
  attributes :url, :credit, :img_sizes
end
