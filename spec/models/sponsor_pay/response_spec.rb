require 'spec_helper'

describe SponsorPay::Response do
  it "should raise SecurityError when the signature does not match the response body" do
    http_response = mock(:body => '{"response": "body"}', :[] => lambda {|header| 'fake signature' })
    expect { SponsorPay::Response.new(http_response) }.to raise_error(SecurityError)
  end
end
