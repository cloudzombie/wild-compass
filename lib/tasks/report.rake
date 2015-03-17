require 'csv'

namespace :report do
  desc "display plants report by lots"
  task plants_with_lots: :environment do

    CSV.open("public/plants.csv", "wb") do |csv|
      csv << [ 'Plant ID', 'Lot ID' ]
      Plant.all.each do |plant|
        csv << [ plant.name, ( plant.lot.nil? ? nil : plant.lot.id ) ]
      end
    end
    
  end
end
