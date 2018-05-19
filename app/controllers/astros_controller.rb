class AstrosController < ApplicationController
  before_action :set_astro, only: [:show, :edit, :update, :destroy]
  # GET /astros
  def index
    @astros = Astro.order(:id)
  end

  # GET /astros/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_astro
      @astro = Astro.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def astro_params
      params.require(:astro).permit(:name, :pic, :start_date, :end_date)
    end
end
