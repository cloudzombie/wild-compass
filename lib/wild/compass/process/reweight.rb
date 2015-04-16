class Wild::Compass::Process::Reweight

  class ReweightError < StandardError
  end

  class CommitFailed < ReweightError
  end

  def initialize(bag)
    raise ReweightError, "" if bag.nil?
    @bag = bag
  end

  def read_from_scale
    (@scale ||= Scale.new('http://localhost:8080')).read
  end

  def commit
    @bag.update_attributes!(current_weight: read_from_scale)
  rescue ActiveRecord::RecordInvalid => e
    Raven.capture_exception(e)
    raise CommitFailed.new(e), "Record was invalid"
  rescue Wild::Compass::Process::Scale::Reading::UnstableReading => e
    Raven.capture_exception(e)
    raise CommitFailed.new(e), "Reading was unstable"
  end

end