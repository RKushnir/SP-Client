require 'spec_helper'
require 'cgi'

describe SponsorPay::Query do
  before { SponsorPay.stub(api_key: 'e95a21621a1865bcbae3bee89c4d4f84')}
  subject { SponsorPay::Query.new(valid_attributes) }

  it "should give produce correct query string" do
    params = CGI::parse(subject.to_s)
    params['appid'].should == ['157']
    params['device_id'].should == ['2b6f0cc904d137be2e1730235f5664094b831186']
    params['ip'].should == ['212.45.111.17']
    params['locale'].should == ['de']
    params['page'].should == ['2']
    params['ps_time'].should == ['1312211903']
    params['pub0'].should == ['campaign2']
    params['uid'].should == ['player1']
    params['timestamp'].should == ['1312553361']
    params['hashkey'].should == ['7a2b1604c03d46eec1ecd4a686787b75dd693c4d']
  end

  def valid_attributes
    {
      appid: 157,
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      ip: '212.45.111.17',
      locale: 'de',
      page: 2,
      ps_time: 1312211903,
      pub0: 'campaign2',
      uid: 'player1',
      timestamp: 1312553361
    }
  end
end
