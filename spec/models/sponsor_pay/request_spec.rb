require 'spec_helper'

describe SponsorPay::Request do
  subject { SponsorPay::Request.new(valid_attributes) }

  describe "validations" do
    context "when format is set in settings" do
      before { SponsorPay.stub(:format => 'json') }
      it "should not raise ArgumentError without format" do
        expect { SponsorPay::Request.new(valid_attributes.except :format) }.to_not raise_error(ArgumentError)
      end
    end

    context "when format is not set in settings" do
      before { SponsorPay.stub(:format => nil) }
      it "should raise ArgumentError without format" do
        expect { SponsorPay::Request.new(valid_attributes.except :format) }.to raise_error(ArgumentError)
      end
    end

    context "when application ID is set in settings" do
      before { SponsorPay.stub(:application_id => 157) }
      it "should not raise ArgumentError without application ID" do
        expect { SponsorPay::Request.new(valid_attributes.except :application_id) }.to_not raise_error(ArgumentError)
      end
    end

    context "when application ID is not set in settings" do
      before { SponsorPay.stub(:application_id => nil) }
      it "should raise ArgumentError without application ID" do
        expect { SponsorPay::Request.new(valid_attributes.except :application_id) }.to raise_error(ArgumentError)
      end
    end

    context "when locale is set in settings" do
      before { SponsorPay.stub(:locale => 'de') }
      it "should not raise ArgumentError without locale" do
        expect { SponsorPay::Request.new(valid_attributes.except :locale) }.to_not raise_error(ArgumentError)
      end
    end

    context "when locale is not set in settings" do
      before { SponsorPay.stub(:locale => nil) }
      it "should raise ArgumentError without locale" do
        expect { SponsorPay::Request.new(valid_attributes.except :locale) }.to raise_error(ArgumentError)
      end
    end

    it "should raise ArgumentError without user ID" do
      expect { SponsorPay::Request.new(valid_attributes.except :user_id) }.to raise_error(ArgumentError)
    end

    it "should raise ArgumentError without device ID" do
      expect { SponsorPay::Request.new(valid_attributes.except :device_id) }.to raise_error(ArgumentError)
    end
  end

  it "should get a response" do
    subject.response.code.should == "OK"
  end

  def valid_attributes
    {
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      ip: '109.235.143.113',
      offer_types: 112,
      user_id: 'player1',
      registered_at: 1.month.ago,
      custom: ['campaign2']
    }
  end
end
