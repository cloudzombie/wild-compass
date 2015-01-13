require 'csv'

namespace :csv do

  desc "Import bags data from csv file"
  task :import_bags, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing bags data..."

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      bag = Bag.create!(
        initial_weight: col[2],
        weight:         col[3],
        lot_id:         col[4]  
      )

      puts "Created bag:\n\tid:\t\t\t#{bag.id}\n\tinitial_weight:\t\t#{bag.initial_weight}\n\tweight:\t\t\t#{bag.weight}\n\torigin:\t\t\t#{bag.origin}\n\n"
    end
  end

  desc "Import jars data from csv file"
  task :import_jars, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing jars data..."

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      jar = Jar.create!(
        bag_id: col[0],
        weight: col[1]
      )

      puts "Created jar:\n\tid:\t\t#{jar.id}\n\tbag_id:\t\t#{jar.bag_id}\n\tweight:\t\t#{jar.weight}\n\n"
    end
  end

  desc "Import lots data from csv file"
  task :import_lots, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing lots data..."

    CSV.foreach(args.filename, { headers: false }) do |col|

      containers = []
      col[1].split(' ').each do |id|
        begin
          containers << Container.find(id)
        rescue
          puts "CONTAINER NOT FOUND FOR #{id}"
        end
      end

      strains = []
      col[3].split(' ').each do |acronym|
        begin
          strains << Strain.find_by(acronym: acronym)
        rescue
          puts "STRAIN NOT FOUND FOR #{acronym}"
        end
      end

      plants = []
      strains.each do |strain|
        strain.plants.each do |plant|
          plants << plant
        end
      end
      
      weight = col[4].nil? ? 0.0 : col[4].to_d

      lot = Lot.new(
        name:           col[0],
        containers:     containers,
        category:       col[2],
        strains:        strains,
        plants:         plants,
        initial_weight: weight,
        current_weight: weight
      )

      begin
        puts lot.save!
      rescue
        puts lot.errors.inspect
      end

    end
  end

  desc "Import orders data from csv file"
  task :import_orders, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing order data..."

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      order = Order.create!(
        customer:  col[0],
        shipped:   col[1],
        timestamp: DateTime.parse(col[2])
      )

      puts "Created order:\n\tcustomer:\t\t\t#{order.customer}\n\tshipped:\t\t\t#{order.shipped}\n\ttimestamp:\t\t\t#{order.timestamp}\n\n"
    end
  end

  desc "Import bags data from csv file"
  task :import_plants, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing bags data..."

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      plant = Plant.create!(
        initial_weight: col[2],
        weight:         col[3],
        lot_id:         col[4]  
      )

      puts "Created bag:\n\tid:\t\t\t#{bag.id}\n\tinitial_weight:\t\t#{bag.initial_weight}\n\tweight:\t\t\t#{bag.weight}\n\torigin:\t\t\t#{bag.origin}\n\n"
    end
  end

  desc "Import bags data from csv file"
  task :import_containers, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing bags data..."

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      container = Container.create!(
        initial_weight: col[2],
        current_weight: col[3],
        lot_id:         col[4]  
      )

      puts "Created bag:\n\tid:\t\t\t#{bag.id}\n\tinitial_weight:\t\t#{bag.initial_weight}\n\tweight:\t\t\t#{bag.weight}\n\torigin:\t\t\t#{bag.origin}\n\n"
    end
  end

  desc "Import inventory data from csv file"
  task :import_inventory, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing inventory data..."

    CSV.foreach(args.filename, { headers: false }) do |col|
      plant = Plant.new(
        strain: Strain.find_by(acronym: col[0].split('-').join.upcase),
        id: col[2],
        format: Format.find_by(name: col[3].split(' ').join.upcase),
        name: "Plant-#{col[1]}",
        current_weight: 0.0,
        initial_weight: 0.0
      )
      plant.save

      col[19].split(' ').each do |id|
        if id.to_i > 0
          if Container.exists? id
            trim_container = Container.find id
            trim_container.current_weight += 0.0
            trim_container.initial_weight += ( col[20].nil? ? 0.0 : col[20].to_d )
          else
            trim_container = Container.new(
              id: id, name: "Container-#{id.to_i}-T",
              current_weight: 0.0,
              initial_weight: ( col[20].nil? ? 0.0 : col[20].to_d )
            )
          end
          trim_container.save
        end
      end

      col[21].split(' ').each do |id|
        if id.to_i > 0
          if Container.exists? id
            buds_container = Container.find id
            buds_container.current_weight += 0.0
            buds_container.initial_weight += ( col[22].nil? ? 0.0 : col[22].to_d )
          else
            buds_container = Container.new(
              id: id, name: "Container-#{id.to_i}",
              current_weight: 0.0,
              initial_weight: ( col[22].nil? ? 0.0 : col[22].to_d )
            )
          end
          buds_container.save
        end
      end

    end
  end
end