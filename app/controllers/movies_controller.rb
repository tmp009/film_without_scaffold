class MoviesController < ApplicationController
    before_action :set_movie, only: %i[show update edit destroy]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    def new
      @movie = Movie.new
    end
  
    def index
      @movies = Movie.all
    end
  
    def show
      render json: @movie
    end

    def edit
        @movie = Movie.find(params[:id])
      end
  
    def create
      @movie = Movie.new(movie_params)
  
      respond_to do |format|
        if @movie.save
          format.json { render json: { movie: @movie, message: 'movie created successfully' }, status: :created }
        else
          format.json { render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @movie.update(movie_params)
          format.json { render json: { movie: @movie, message: 'Movie updated successfully' }, status: :ok }
        else
          format.json { render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      respond_to do |format|
        if @movie.destroy
          format.json { render json: { message: 'Movie deleted successfully' }, status: :ok }
        else
          format.json { render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
  
    private
  
    def record_not_found
      respond_to do |format|
        format.json { render json: { error: "Movie with the id #{params[:id]} not found" }, status: :not_found }
        format.any  { head :not_found }
      end
    end
  
    def set_movie
      @movie = Movie.find(params[:id])
    end
  
    def movie_params
      params.require(:movie).permit(:title, :description)
    end
end
