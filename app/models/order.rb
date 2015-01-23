class Order < ActiveRecord::Base



  def self.search(search)
    if search
      where("name like ?", "%#{search}%")
    else
      all
    end
  end



  ### Order lines

  has_many :order_lines
  
  accepts_nested_attributes_for :order_lines,
                                 allow_destroy: true,
                                 reject_if: :all_blank



  ### Customer

  validates :customer, presence: true



  def datamatrix
    open("http://datamatrix.kaywa.com/img.php?s=12&d=#{ encode self.try(:id) }").read
  end



  def encode(id)
    text = "ORDER-#{id}"
    hash = Digest::MD5.base64digest(text)
    update datamatrix_text: text, datamatrix_hash: hash
    hash
  end


  

  ### Total weight

  ## 
  # Computes order's total weight
  def total_weight
    w = 0.0
    order_lines.each do |line|
      w += line.quantity * (line.jar.nil? ? 0.0 : line.jar.current_weight )
    end
    w
  end
end
