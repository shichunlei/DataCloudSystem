class MusicsController < ApplicationController
  before_action :set_music, only: [:show, :edit, :update, :destroy]

  # GET /musics
  def index
    @page = params[:page]
    @musics = Music.order(:id).page(@page).per(30)
  end

  # GET /musics/1
  def show
    @page = params[:page].nil? ? 1 : params[:page]
  end

  # GET /musics/new
  def new
    @music = Music.new
  end

  # GET /musics/1/edit
  def edit
  end

  # POST /musics
  def create
    @music = Music.new(music_params)

    if @music.save
      redirect_to @music, notice: "创建成功"
    else
      render :new
    end
  end

  # PATCH/PUT /musics/1
  def update
    if @music.update(music_params)
      redirect_to @music, notice: "修改成功."
    else
      render :edit
    end
  end

  # DELETE /musics/1
  def destroy
    @music.destroy
    redirect_to musics_url, notice: "删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def music_params
      params.require(:music).permit(:id, :name, :audio_url, :artists, :album_url, :lyric)
    end
end
