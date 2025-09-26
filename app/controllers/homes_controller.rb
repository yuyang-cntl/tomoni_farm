class HomesController < ApplicationController
  skip_before_action :redirect_guest_to_root, only: [:top, :about]
  def top
  end

  def about
    @farmers = Farmer.all
  end
end
