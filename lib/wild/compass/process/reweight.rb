class Wild::Compass::Process::Reweight

  def initialize(bag_id)
    @bag = Bag.find(bag_id)
  end

  def read_from_scale
    (@scale ||= Scale.new('localhost', 8080)).read
  end

end