require 'test_helper'

class BinTest < ActiveSupport::TestCase
  test 'should save a new instance' do
    bin = Bin.new
    assert bin.save, 'could not save a new instance'
  end
end
