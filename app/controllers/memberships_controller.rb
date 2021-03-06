class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
    @beer_clubs = BeerClub.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @beer_clubs = BeerClub.all
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    @membership.user = current_user
    @beer_clubs = BeerClub.all
    respond_to do |format|
      if not_duplicate_membership(@membership.beer_club) && @membership.save
        format.html { redirect_to @membership, notice: '%{user} welcome to the club' % { user: current_user.username } }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    name = @membership.beer_club.name
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to user_url, notice: 'Membership in %{membership} ended' % { membership: name } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end

  def not_duplicate_membership(beer_club)
    if current_user.memberships.find_by(id: beer_club.id)
      return false
    end

    true
  end
end
