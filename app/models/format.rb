class Format < ActiveRecord::Base
  
  before_save :upcase_name

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  private

    def upcase_name
      self.name = name.to_s.split(' ').join.upcase
    end

end
