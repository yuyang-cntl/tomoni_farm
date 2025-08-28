class Farmer::HomesController < ApplicationController
  before_action :authenticate_farmer!
  def top
  end
end
