module Encodable
  extend ActiveSupport::Concern

  def datamatrix
    open("http://datamatrix.kaywa.com/img.php?s=12&d=#{ encode }").read
  end

  def encode
    return self.datamatrix_hash if has_datamatrix_hash?
    text = "#{identifier}-#{unique_identifier}"
    hash = Digest::MD5.hexdigest(text)
    update datamatrix_text: text, datamatrix_hash: hash unless has_datamatrix_hash?
    hash
  end

  private

    def identifier
      self.class.name.upcase
    end

    def unique_identifier
      case self.class
      when Bag
        self.name
      else
        self.id
      end
    end

    def has_datamatrix_hash?
      !self.datamatrix_hash.nil?
    end
end