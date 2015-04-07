module Encodable
  extend ActiveSupport::Concern

  included do
    attr_accessor :scanned_hash
    
    validates :datamatrix_hash, uniqueness: true, presence: false, allow_blank: true
    validates :datamatrix_text, uniqueness: true, presence: false, allow_blank: true

    before_save :upcase_datamatrix_text, if: :datamatrix_text_exists?
    before_save :downcase_datamatrix_hash, if: :datamatrix_hash_exists?
  end

  def datamatrix
    open("http://datamatrix.kaywa.com/img.php?s=12&d=#{ encode }").read
  end

  def encode
    return self.datamatrix_hash if has_datamatrix_hash?
    text = "#{identifier}-#{unique_identifier}"
    hash = Digest::MD5.hexdigest(text)
    update_attributes!(datamatrix_text: text, datamatrix_hash: hash) unless has_datamatrix_hash?
    hash
  rescue ActiveRecord::RecordInvalid => e
    Raven.capture_exception(e)
    ''
  end

  private

    def datamatrix_text_exists?
      !self.datamatrix_text.nil?
    end

    def datamatrix_hash_exists?
      !self.datamatrix_hash.nil?
    end

    def upcase_datamatrix_text
      self.datamatrix_text = self.datamatrix_text.upcase
    end

    def downcase_datamatrix_hash
      self.datamatrix_hash = self.datamatrix_hash.downcase
    end

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