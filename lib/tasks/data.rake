namespace :data do
  desc "TODO"
  task generate: :environment do
  	20.times do |i|
  		Lot.create(
  			name: "#{i}THC2015"
  		)

  		Bin.create(
  			name: "BIN - #{i}",
  		)

  		Bag.create(
  			name: "BAG-#{i}",
  			current_weight: weight = 500 + rand * 10,
  			initial_weight: weight,
  		)
  	end
  end

end
