require 'csv'

namespace :csv do

  desc "Import bags data from csv file"
  task :import_bags, [ :filename ] => :environment do |t, args|
    raise "No input CSV file specified" if args.filename.nil?

    puts "Importing bags data..."

    CSV.foreach(args.filename, { headers: :first_row }) do |col|
      
      bag = Bag.create!(
        #type:             col[2],
        #strain:           col[3],
        initial_weight:   col[4],
        weight:           col[5],
        origin:           col[6]
      )

      puts "Created bag:\n\tid:\t\t#{bag.id}\n\tinitial_weight:\t\t#{bag.initial_weight}\n\tweight:\t\t#{bag.weight}\n\torigin:\t\t#{bag.origin}\n\n"
    end
  end
end