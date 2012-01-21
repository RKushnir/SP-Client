require 'spec_helper'

describe "offers/index.html.haml" do
  let (:thumbnail) { mock(:thumbnail, lowres: 'image1.png') }
  let (:offer1) { mock(:offer, title: 'Offer 1', payout: 10, thumbnail: thumbnail) }
  let (:offer2) { mock(:offer, title: 'Offer 2', payout: 20, thumbnail: thumbnail) }

  context "when form has been submitted" do
    before do
      assign(:search, mock(successful?: true))
      assign(:offers, paginated_array([offer1, offer2]))
    end

    it "displays the offers list if search was successful" do
      render
      rendered.should =~ /Offer 1/
    end

    it "renders _offer partial for each offer" do
      render
      view.should render_template(:partial => "_offer", :count => 2)
    end
  end

  def paginated_array(array)
    WillPaginate::Collection.create(1, 20, array.length) do |pager|
      pager.replace array[pager.offset, pager.per_page].to_a
    end
  end
end
