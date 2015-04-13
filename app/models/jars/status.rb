class Jars::Status < ActiveRecord::Base

  belongs_to :jar

  belongs_to :location
  
end
