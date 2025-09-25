class HomesController < ApplicationController
  skip_before_action :redirect_guest_to_root, only: [:top]
  def top
    @farmer = Farmer.find_by(email: 'farmer@example.com')
  end

  def about
  end
end
