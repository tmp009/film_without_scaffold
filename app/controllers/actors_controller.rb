class ActorsController < ApplicationController
  before_action :set_actor, only: %i[show update edit destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def new
    @actor = Actor.new
  end

  def index
    @actors = Actor.all
  end

  def show
    render json: @actor
  end

  def edit
    @actor = Actor.find(params[:id])
  end

  def create
    @actor = Actor.new(actor_params)

    respond_to do |format|
      if @actor.save
        format.json { render json: { actor: @actor, message: 'Actor created successfully' }, status: :created }
      else
        format.json { render json: { errors: @actor.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @actor.update(actor_params)
        format.json { render json: { actor: @actor, message: 'Actor updated successfully' }, status: :ok }
      else
        format.json { render json: { errors: @actor.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @actor.destroy
        format.json { render json: { message: 'Actor deleted successfully' }, status: :ok }
      else
        format.json { render json: { errors: @actor.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def record_not_found
    respond_to do |format|
      format.json { render json: { error: "Actor with the id #{params[:id]} not found" }, status: :not_found }
      format.any  { head :not_found }
    end
  end

  def set_actor
    @actor = Actor.find(params[:id])
  end

  def actor_params
    params.require(:actor).permit(:first_name, :last_name)
  end
end