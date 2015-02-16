namespace :transactions do
  desc "fixes transactions"
  task fix: :environment do
    (0..180).each do |i|
      c = Container.where(name: "CTN-#{i}")
      
      if c.first != c.last
        c.last.transactions.each do |t|
          if t.target == c.last
            t.target = c.first
          elsif t.source == c.last
            t.source = c.first
          end
          t.save
        end
      end

      d = Container.where(name: "CTN-#{i}-T")

      if d.first != d.last
        d.last.transactions.each do |t|
          if t.target == d.last
            t.target = d.first
          elsif t.source == d.last
            t.source = d.first
          end
          t.save
        end
      end
    end
  end
end
