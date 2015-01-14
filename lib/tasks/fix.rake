require 'csv'

namespace :fix do
  
  desc "fixes links from csv file"
  task :link, [ :inventory, :lots ] => :environment do |t, args|

    puts "Attempting to fix links..."

    plants = {}
    lots, containers = []

    CSV.foreach(args[:inventory].filename, { headers: false }) do |col|

      id = col[2].to_i

      next unless id.to_i > 0  || col[19].to_i > 0 || col[21].to_i > 0 || !id.nil? || !col[19].nil? || !col[21].nil?

      buds_containers, trim_containers = []

      plant = Plant.find(id)

      col[19].split(' ').each do |id|
        trim_containers << Container.find(id)
      end

      col[21].split(' ').each do |id|
        buds_containers << Container.find(id)
      end

      plants[id] = {
        :plant => plant,
        :trim_containers => trim_containers,
        :buds_containers => buds_containers
      }

    end

    puts plants
    exit

    CSV.foreach(args[:lots].filename, { headers: false }) do |col|

      col[1].split(' ').each do |id|
        begin
          containers << Container.find(id)
        rescue
          puts "CONTAINER NOT FOUND FOR #{id}"
        end
      end

      weight = col[4].nil? ? 0.0 : col[4].to_d

      lot = Lot.find_or_create_by(
        id: col[0],
        name: "#{col[0]}THC2014",
        initial_weight: weight,
        current_weight: weight,
        category: col[2]
      )

      plants.each do |plant|
        plant.lot_id = lot.id
        plant.save
      end

      containers.each do |container|
        container.lot_id = lot.id
        container.save
      end
    end
  end
end