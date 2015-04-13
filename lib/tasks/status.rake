namespace :status do
  desc "creates status for bags and jars"
  task create: :environment do
    [Bag, Jar].each do |model|
      model.all.each do |m|
        m.save!
      end
    end
  end

  desc "updates status from bags and jars"
  task update: :environment do
    [Bag, Jar].each do |model|
      model.all.each do |m|
        m.status.update!(is_destroyed: m.is_destroyed) if m.respond_to?(:is_destroyed)
        m.status.update!(sent_to_lab: m.sent_to_lab) if m.respond_to?(:sent_to_lab)
        m.save!
      end
    end
  end

end
