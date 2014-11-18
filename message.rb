class Message

  include DataMapper::Resource

  property :id, Serial
  property :timestamp, DateTime, required: true
  property :ip, String, required: true
  property :message, String, required: true

end
