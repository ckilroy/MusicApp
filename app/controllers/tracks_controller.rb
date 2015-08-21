class TracksController < ApplicationController
before_action :require_current_user!

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      render :show
    else
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

    if @band.update(band_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy #delete does not run the callbacks!

    redirect_to bands_url
  end


  def track_params
    params.require(:track).permit(:song, :album_id, :cut_type, :lyrics)
  end

end
