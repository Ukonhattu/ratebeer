class StylesController < ApplicationController
  before_action :ensure_that_admin, only: [:destroy]

  def index
    @styles = Style.all
  end

  def show
    @style = Style.find(params[:id])
  end

  def destroy
  end
end
