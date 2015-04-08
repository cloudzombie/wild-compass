require 'net/http'

class Wild::Compass::Process::Scale

  def initialize(url)
    @url = url
  end

  def zero
    url = URI.parse([@url.to_s, 'zero'].join('/'))
    req = Net::HTTP::Get.new(@url.to_s)
    
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end

    res.body
  end

  alias_method :tare, :zero

  def weight
    url = URI.parse([@url.to_s, 'data'].join('/'))
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    res.body.to_f
  end

  alias_method :read, :weight

end