require 'net/http'

class Wild::Compass::Process::Scale
  class ScaleError < StandardError
  end

  class ScaleServerUnavailable < ScaleError
  end

  class Reading
    class ReadingError < StandardError
    end

    class InvalidReading < ReadingError
    end

    class NullReading < InvalidReading
    end

    class UnstableReading < ReadingError
    end

    def initialize(read)
      raise InvalidReading, "Reading did not receive a string" unless read.kind_of?(String)
      raise NullReading, "Reading is null" if read.nil?
      @read = read
      raise UnstableReading, "Reading an unstable weight" unless stable?
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
    raise ScaleServerUnavailable.new(e), "Could not connect to scale server"
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
    raise ScaleServerUnavailable.new(e), "Could not connect to scale server"
  end

  alias_method :read, :weight

end