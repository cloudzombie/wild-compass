require 'net/http'

class Wild::Compass::Process::Scale

  class ScaleServerUnavailableException < Exception
  end

  class Reading
    class InvalidReadingException < Exception
    end

    class NullReadingException < InvalidReadingException
    end

    def initialize(read)
      raise InvalidReadingException, "Scale did not read a string" if !read.kind_of?(String)
      raise NullReadingException, "Scale read null" if read.nil?
      @read = read
    end

    def stable?
      !@read.contains?('?')
    end
  end

  def initialize(url)
    @url = url
  end

  def zero
    url = URI.parse([@url.to_s, 'zero'].join('/'))
    req = Net::HTTP::Get.new(@url.to_s)
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    Reading.new(res.body)
  rescue Errno::ECONNREFUSED => e
    raise ScaleServerUnavailableException.new(e), "Could not connect to scale server"
  end

  alias_method :tare, :zero

  def weight
    url = URI.parse([@url.to_s, 'data'].join('/'))
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    Reading.new(res.body)
  rescue Errno::ECONNREFUSED => e
    raise ScaleServerUnavailableException.new(e), "Could not connect to scale server"
  end

  alias_method :read, :weight

end