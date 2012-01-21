class OffersController < ApplicationController
  rescue_from ArgumentError, :with => :invalid_parameter
  rescue_from SecurityError, :with => :invalid_response_from_service

  def index
    if params[:submit]
      search_params = params.slice(:user_id, :custom, :page).merge(sample_data)

      @search = OfferSearch.new(search_params)
  	  @offers = paginated_search_results(@search)
    end
  end

  private

  def sample_data
    {
      device_id: "2b6f0cc904d137be2e1730235f5664094b831186",
      ip: "109.235.143.113",
      offer_types: 112
    }
  end

  def paginated_search_results(search)
    WillPaginate::Collection.create(params[:page] || 1, 20, search.count) do |pager|
      pager.replace search.offers[pager.offset, pager.per_page].to_a
    end
  end

  def invalid_parameter(exception)
    render :text => "Error: #{exception.message}", :status => :bad_request
  end

  def invalid_response_from_service(exception)
    render :text => "Error: #{exception.message}", :status => :internal_server_error
  end

end
