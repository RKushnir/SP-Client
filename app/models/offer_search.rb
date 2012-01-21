class OfferSearch
  delegate :successful?, :offers, :message, :count, :pages, :information, :to => :result

  def initialize(params={})
    @request = SponsorPay::Request.new(params)
  end

  private

  def result
    @result ||= @request.response
  end
end
