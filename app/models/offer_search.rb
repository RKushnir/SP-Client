class OfferSearch
  delegate :successful?, :message, :information, :to => :result

  def initialize(params={})
    @request = SponsorPay::Request.new(params)
  end

  def offers
    successful? ? result.offers : []
  end

  def count
    successful? ? result.count : 0
  end

  def pages
    successful? ? result.pages : 0
  end

  private

  def result
    @result ||= @request.response
  end
end
