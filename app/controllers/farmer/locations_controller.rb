class Farmer::LocationsController < ApplicationController
  def index
    farmers = Farmer.includes(:location).where.not(locations: { latitude: nil, longitude: nil })

    render json: {
      data: {
        farmers: farmers.map do |farmer|
          {
            id: farmer.id,
            name: farmer.name,
            latitude: farmer.location.latitude,
            longitude: farmer.location.longitude
          }
        end
      }
    }
  end

end
