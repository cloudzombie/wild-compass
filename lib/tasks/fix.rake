require 'csv'

namespace :fix do

  desc "fixes links from csv file"
  task :link, [ :inventory, :lots ] => :environment do |t, args|

    puts "Attempting to fix links..."

    plants = {}
    lots, containers = []

    CSV.foreach(args[:inventory], { headers: false }) do |col|

      id = col[2].to_i
      next unless id > 0  || col[19].to_i > 0 || col[21].to_i > 0 || !id.nil? || !col[19].nil? || !col[21].nil?

      buds_containers = []
      trim_containers = []

      plant = Plant.find(id)

      col[19].split(' ').each do |id|
        trim_containers << id.to_i if id.to_i > 0 && !id.to_i.nil?
      end

      col[21].split(' ').each do |id|
        buds_containers << id.to_i if id.to_i > 0 && !id.to_i.nil?
      end

      plants[id] = {
        :plant => plant,
        :trim_containers => trim_containers,
        :buds_containers => buds_containers
      }

    end

    CSV.foreach(args[:lots], { headers: false }) do |col|

      puts "LOT : #{col[0].to_i}"

      containers = []

      col[1].split(' ').each do |id|
        begin
          containers << Container.find(id)
        rescue
          puts "CONTAINER NOT FOUND FOR #{id}"
        end
      end

      weight = col[4].nil? ? 0.0 : col[4].to_d

      lot = Lot.find_or_create_by(
        id: col[0].to_i,
        name: "#{col[0]}THC2014",
        initial_weight: weight,
        current_weight: weight,
        category: col[2]
      )

      lot_plants = []

      containers.each do |container|
        container.lot_id = lot.id
        container.save!
        plants.each do |id, plant_map|
          plant_map[:buds_containers].each do |buds_container_id|
            lot_plants << plant_map[:plant] if container.id == buds_container_id
          end

          plant_map[:trim_containers].each do |trim_container_id|
            lot_plants << plant_map[:plant] if container.id == trim_container_id
          end
        end
      end

      puts "COULD NOT FIND PLANTS FOR CONTAINERS: #{containers}" if lot_plants.empty?
      lot_plants.uniq!

      lot_plants.each do |plant|
        plant.lot_id = lot.id
        plant.save!
      end
    end
  end
end