# frozen_string_literal: true

# Manages routes for friendships
class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_friendship, only: :create
  before_action :set_friendship, only: %i[show edit update destroy]

  # GET /friendships or /friendships.json
  def index
    return unless current_user.profile
    @profile = current_user.profile
    @friendships = Friendship.where(friend_id: @profile.id,
                                    status: :accepted).or(Friendship.where(
                                                            buddy_id: @profile.id, status: :accepted
                                                          ))
  end

  # GET /friendships/1 or /friendships/1.json
  def show; end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
    authorize @friendship
  end

  # GET /friendships/1/edit
  def edit; end

  # POST /friendships or /friendships.json
  def create
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: "Friendship was successfully created." }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendships/1 or /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: "Friendship was successfully updated." } # friend made = buddy up
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: "Friendship was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def create_friendship
    @friendship = Friendship.new(friendship_params)
    authorize @friendship
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = policy_scope(Friendship).find(params[:id])
    authorize @friendship
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:friend_id, :buddy_id, :status)
  end
end
