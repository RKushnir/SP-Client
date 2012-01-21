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
end
