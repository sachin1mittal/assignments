require 'net/http'

class RestClient

  def self.get(url)
    begin
      uri = URI(url)
      Net::HTTP.get(uri)
    rescue
      '[]'
    end
  end
end
