require 'csv'

namespace :csv do

  desc "Import bags data from csv file"
  task :import_bags, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing bags data..."

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      bag = Bag.create!(
        initial_weight:   col[2],
        weight:           col[3],
        origin:           col[4]
      )

      puts "Created bag:\n\tid:\t\t#{bag.id}\n\tinitial_weight:\t\t#{bag.initial_weight}\n\tweight:\t\t#{bag.weight}\n\torigin:\t\t#{bag.origin}\n\n"
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

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      lot = Lot.create!(
        name:           col[0],
        strain:         col[1],
        type:           col[2],
        initial_weight: col[3],
        weight:         col[4],
        origin:         col[5]
      )

      puts "Created lot:\n\tid:\t\t#{lot.id}\n\tname:\t\t#{lot.name}\n\tstrain:\t\t#{lot.strain}\n\ttype:\t\t#{lot.type}\n\tinitial_weight:\t\t#{lot.initial_weight}\n\tweight:\t\t#{lot.weight}\n\torigin:\t\t#{lot.origin}\n\n"
    end
  end
end