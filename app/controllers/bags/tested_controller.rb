class Bags::TestedController < ApplicationController

  expose(:strains) { Strain.all }
  expose(:bags) { Bag.tested }

  def home
  end
end
