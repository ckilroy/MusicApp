class AlbumsController < ApplicationController
before_action :require_current_user!

  def create
    @album = Album.new(album_params)

    if @album.save
      render :show
    else
      render :new
    end
  end

  def new
    @album = Album.new
    render :new
  end

  def show
    @album = Album.find(params[:id])

    render :show
  end


  def edit
    @album = Album.find(params[:id])

    render :edit
  end

  def update
    @album = Band.find(params[:id])

    if @album.update(album_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to bands_url
  end


  private

  def album_params
    params.require(:album).permit(:title, :band_id, :recording_type)
  end

end
