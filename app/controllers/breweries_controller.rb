# frozen_string_literal: true

class BreweriesController < ApplicationController
  # Breweries controller
  before_action :set_brewery, only: %i[show edit update destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :ensure_that_admin, only: [:destroy]

  # GET /breweries
  # GET /breweries.json
  def index
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show; end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit; end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html do
          redirect_to @brewery,
                      notice: 'Brewery was successfully created.'
        end
        format.json do
          render :show, status: :created,
                        location: @brewery
        end
      else
        format.html { render :new }
        format.json do
          render json: @brewery.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, !brewery.active

    new_status = brewery.active? ? "active" : "retired"

    redirect_to brewery, notice: "brewery activity status changed to #{new_status}"
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html do
          redirect_to @brewery,
                      notice: 'Brewery was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json do
          render json: @brewery.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy
    respond_to do |format|
      format.html do
        redirect_to breweries_url,
                    notice: 'Brewery was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brewery
    @brewery = Brewery.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def brewery_params
    params.require(:brewery).permit(:name, :year, :active)
  end
end
