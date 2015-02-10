require 'test_helper'

class BagTest < ActiveSupport::TestCase
  test 'should save a new instance' do
    bag = Bag.new
    assert bag.save, 'could not save a new instance'
  end
end
