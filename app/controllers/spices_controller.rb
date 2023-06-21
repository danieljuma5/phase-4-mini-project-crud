class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_spice_not_found_status
  def index
    spices = Spice.all
    render json: spices
  end
  def create
    spice  = Spice.create(spice_params)
    render json: spice, status: :created
    
  end
  def update
    spice =  find_by
    if spice
      spice.update(spice_params)
      render json: spice
    else
      render_spice_not_found_status
    end
  end
  def destroy
    spice =  find_by
    if spice
      spice.destroy
      head :no_content
    else
      render_spice_not_found_status
    end
  end

  private
  def find_by
    spice = Spice.find(params[:id])
  end
  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end
  def render_spice_not_found_status
    render json: {error: "Spice not found"}, status: :not_found
  end

end
