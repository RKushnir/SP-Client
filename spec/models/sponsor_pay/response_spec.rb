require 'spec_helper'

describe SponsorPay::Response do
  let (:http_response) { mock(:body => '{"response": "body"}', :[] => lambda {|header| 'fake signature' }) }
  it "should raise SecurityError when the signature does not match the response body" do
    expect { SponsorPay::Response.new(http_response, 'json') }.to raise_error(SecurityError)
  end

  it "should raise UnsupportedFormatError when given an unsupported" do
    expect { SponsorPay::Response.new(http_response, 'abc') }.to raise_error(SponsorPay::UnsupportedFormatError)
  end
end
