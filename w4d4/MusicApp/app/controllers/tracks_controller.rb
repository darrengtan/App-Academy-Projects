class TracksController < ApplicationController
  before_action :require_user!

  def new
    @track = Track.new
    set_track_to_current_album(@track)
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track.update_attributes(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy!
    redirect_to band_url(@track.band)
  end

  private
  def track_params
    params.require(:track).permit(:album_id, :track_name, :lyrics, :track_type)
  end

  def set_track_to_current_album(track)
    track.album_id = params[:album_id]
  end
end
