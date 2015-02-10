require 'test_helper'

class SeedTest < ActiveSupport::TestCase
  test 'should save a new instance' do
    seed = Seed.new
    assert seed.save, 'could not save a new instance'
  end
end
