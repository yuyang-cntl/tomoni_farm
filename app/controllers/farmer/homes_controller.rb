class Farmer::HomesController < ApplicationController
  before_action :authenticate_farmer!
  def top
    @farmer = current_farmer
  end
end
