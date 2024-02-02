class ActorsController < ApplicationController
    def new
        @actors = Actor.new()
    end

    def index
        @actors = Actor.all
      end
    
    def show
    end
    
end
