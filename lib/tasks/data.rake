namespace :data do
  desc "TODO"
  task generate: :environment do
  	1000.times do |i|
  		Bag.create(
  			name: "BAG-#{i}",
  			current_weight: weight = 500 + rand * 10,
  			initial_weight: weight
  		)
  	end
  end

end
