class HomesController < ApplicationController
  skip_before_action :redirect_guest_to_root, only: [:top]
  def top
  end

  def about
  end
end
