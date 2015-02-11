class Bags::ArchivedController < ApplicationController

  expose(:strains) { Strain.all }
  expose(:bags) { Bag.archived }

  def home
  end
end
