class Bin < ActiveRecord::Base

  include Labelizable

  has_many :bags

  belongs_to :location
  

  ### Datamatrix

  def datamatrix
    open("http://datamatrix.kaywa.com/img.php?s=12&d=#{ encode self.try(:id) }").read
  end



  def encode(id)
    text = "BIN-#{id}"
    hash = Digest::MD5.hexdigest(text)
    update datamatrix_text: text, datamatrix_hash: hash
    hash
  end

  def available?
    true
  end

  def to_s
    "BIN_#{id}"
  end
end
