require 'spec_helper'

describe OffersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "returns bad request when submitted with invalid parameters" do
      get 'index', :submit => true, :user_id => ''
      response.should be_bad_request
    it "returns internal server error when response's signature validation fails" do
      SponsorPay::Response.any_instance.stub(:hash_key => 'invalid hash key')
      get 'index', :submit => 'submit', :user_id => 'qwerty', :custom => ['asdfgh']
      should respond_with(:internal_server_error)
    end

    it "assigns offers" do
      OfferSearch.any_instance.stub(:successful? => true, :offers => [1, 2, 3])
      get 'index', :submit => 'submit', :user_id => 'qwerty', :custom => ['asdfgh']
      subject.should assign_to(:offers).with([1, 2, 3])
    end

    it "assigns search" do
      OfferSearch.any_instance.stub(successful?: true, offers: [1, 2, 3])
      get 'index', :submit => 'submit', :user_id => 'qwerty', :custom => ['asdfgh']
      subject.should assign_to(:search)
    end

  end

end
