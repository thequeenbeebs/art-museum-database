class PaintingsController < ApplicationController
    def index
        @paintings = Painting.all.sort_by { |p| p.name}
    end

    def new
        @painting = Painting.new
    end

    def create
        artist = Artist.find_or_create_by(name: params[:painting][:artist_name])
        museum = Museum.find_or_create_by(name: params[:painting][:museum_name])
        @painting = Painting.new(
            name: params[:painting][:name],
            year: params[:painting][:year],
            img_url: params[:painting][:img_url],
            artist_id: artist.id,
            museum_id: museum.id)
        if @painting.valid?
            @painting.save
            redirect_to painting_path(@painting)
        else
            render :new
        end
    end

    def show
        @painting = Painting.find(params[:id])
    end

    def edit
        @painting = Painting.find(params[:id])
    end

    def update
        @painting = Painting.find(params[:id])
        @painting = Painting.update(painting_params)
        redirect_to painting_path(@painting)
    end

    def destroy
        @painting = Painting.find(params[:id])
        @painting.destroy
        redirect_to paintings_path
    end

    private

    def painting_params
        params.require(:painting).permit(:name, :year, :img_url, :museum_name, :artist_name)
    end
end
