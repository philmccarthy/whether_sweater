class ImageSerializer
  include JSONAPI::Serializer
  set_id { 'null' }
  attributes :url, :credit, :img_sizes
end
