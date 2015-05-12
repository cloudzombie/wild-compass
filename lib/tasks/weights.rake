namespace :weights do
  desc "TODO"
  task initialize: :environment do
    [Bag, Container, Jar, Lot, Plant, Seed].each do |model|
      model.all.each do |item|
        item.weights << Weight.new(weighted_at: Time.now, value: item.current_weight)
        item.save
      end
    end
  end

end
