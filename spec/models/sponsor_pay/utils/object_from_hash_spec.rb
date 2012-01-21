require 'spec_helper'

describe SponsorPay::Utils::ObjectFromHash do
  it "should accept hashes with string keys" do
    h = SponsorPay::Utils::ObjectFromHash.new('key' => 'value')
    h.key.should == 'value'
  end

  it "should accept hashes with symbol keys" do
    h = SponsorPay::Utils::ObjectFromHash.new(key: 'value')
    h.key.should == 'value'
  end

  it "should accept nested hashes" do
    h = SponsorPay::Utils::ObjectFromHash.new(key: {nested_key: 'value'})
    h.key.nested_key.should == 'value'
  end

  it "should accept arrays" do
    h = SponsorPay::Utils::ObjectFromHash.new(keys: [{nested_key: 'value1'}, {nested_key: 'value2'}])
    h.keys[1].nested_key.should == 'value2'
  end
end
